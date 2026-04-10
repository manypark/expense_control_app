import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/cards/presentation/providers/cards_providers.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_control_app/features/expenses/presentation/presentation.dart';

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    final feedAsync = ref.watch(expenseFeedControllerProvider);
    final cardsById = ref.watch(cardsByIdProvider);
    final monthSummaryAsync = ref.watch(expenseMonthSummaryProvider);
    final currency = NumberFormat.currency(locale: 'es_MX', symbol: r'$');
    final bottomSpace = MediaQuery.of(context).size.height * 0.14;

    return Scaffold(
      body: feedAsync.when(
        data: (feed) => NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 240) {
              ref.read(expenseFeedControllerProvider.notifier).loadMore();
            }
            return false;
          },
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                title: const Text('Gastos'),
                actions: [
                  IconButton(
                    onPressed: () => _openFilters(context, feed.filters),
                    icon: const Icon(Icons.tune),
                    tooltip: 'Filtros',
                  ),
                  IconButton(
                    onPressed: () => _openExpenseForm(context),
                    icon: const Icon(Icons.add),
                    tooltip: 'Agregar gasto',
                  ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                sliver: SliverToBoxAdapter(
                  child: _ExpensesHeader(
                    currency: currency,
                    feed: feed,
                    monthSummaryAsync: monthSummaryAsync,
                    onAction: () => feed.filters.hasFilters
                        ? ref
                              .read(expenseFeedControllerProvider.notifier)
                              .clearFilters()
                        : _openFilters(context, feed.filters),
                  ),
                ),
              ),
              if (feed.items.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: EmptyExpensesText()),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: ExpensesSliverList(
                    expenses: feed.items,
                    cardsById: cardsById,
                    currency: currency,
                    onEdit: (expense) => _openExpenseForm(context, expense),
                    onDelete: (expense) =>
                        _confirmDeleteExpense(context, expense),
                    isLoadingMore: feed.isLoadingMore,
                  ),
                ),
              SliverToBoxAdapter(child: SizedBox(height: bottomSpace)),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  String _dateLabel(ExpenseFeedFilters filters) {
    if (filters.from == null || filters.to == null) {
      return 'Sin rango de fechas';
    }
    final format = DateFormat('dd/MM/yyyy');
    return '${format.format(filters.from!)} - ${format.format(filters.to!)}';
  }

  void _openExpenseForm(BuildContext context, [ExpenseEntity? expense]) {
    final cards = ref.read(availableCardsProvider).valueOrNull ?? const [];
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      showCupertinoModalPopup<void>(
        context: context,
        barrierDismissible: true,
        builder: (_) => Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            clipBehavior: Clip.antiAlias,
            child: ExpenseFormSheet(cards: cards, expense: expense),
          ),
        ),
      ).then((_) {
        ref.read(expenseFeedControllerProvider.notifier).refresh();
      });
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ExpenseFormSheet(cards: cards, expense: expense),
    ).then((_) => ref.read(expenseFeedControllerProvider.notifier).refresh());
  }

  void _openFilters(BuildContext context, ExpenseFeedFilters filters) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ExpenseFiltersSheet(
        selectedCategory: filters.category,
        dateLabel: _dateLabel(filters),
        hasFilters: filters.hasFilters,
        onCategoryChanged: (value) {
          ref.read(expenseFeedControllerProvider.notifier).setCategory(value);
        },
        onPickRange: () {
          Navigator.of(context).pop();
          _pickDateRange(context, filters);
        },
        onClear: () {
          ref.read(expenseFeedControllerProvider.notifier).clearFilters();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _pickDateRange(BuildContext context, ExpenseFeedFilters filters) {
    showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: filters.from != null && filters.to != null
          ? DateTimeRange(start: filters.from!, end: filters.to!)
          : null,
    ).then((range) {
      if (range == null) return;
      ref.read(expenseFeedControllerProvider.notifier).setDateRange(range);
    });
  }

  void _confirmDeleteExpense(BuildContext context, ExpenseEntity expense) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      showCupertinoDialog<bool>(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Eliminar gasto'),
          content: Text(
            'Se eliminara "${expense.title}". Esta accion no se puede deshacer.',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Eliminar'),
            ),
          ],
        ),
      ).then((accepted) {
        if (!context.mounted || accepted != true) return;
        _deleteExpense(context, expense.id);
      });
      return;
    }

    showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar gasto'),
        content: Text(
          'Se eliminara "${expense.title}". Esta accion no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    ).then((accepted) {
      if (!context.mounted || accepted != true) return;
      _deleteExpense(context, expense.id);
    });
  }

  void _deleteExpense(BuildContext context, String expenseId) {
    ref
        .read(expenseCommandsProvider.notifier)
        .deleteExpense(expenseId)
        .then((_) => ref.read(expenseFeedControllerProvider.notifier).refresh())
        .catchError((_) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Hubo un error al eliminar el gasto.'),
            ),
          );
        });
  }
}

class _ExpensesHeader extends StatelessWidget {
  const _ExpensesHeader({
    required this.currency,
    required this.feed,
    required this.monthSummaryAsync,
    required this.onAction,
  });

  final NumberFormat currency;
  final ExpenseFeedState feed;
  final AsyncValue<ExpenseMonthSummary> monthSummaryAsync;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        monthSummaryAsync.when(
          data: (summary) => ExpenseOverviewCard(
            label: summary.label,
            totalText: currency.format(summary.total),
            changeLabel: _changeLabel(summary.changeRatio),
          ),
          loading: () => const ExpenseOverviewCard(
            label: 'MES',
            totalText: r'$0.00',
            changeLabel: 'Cargando resumen...',
          ),
          error: (_, _) => ExpenseOverviewCard(
            label: 'MES',
            totalText: currency.format(feed.total),
            changeLabel: 'Resumen no disponible',
          ),
        ),
        const SizedBox(height: 24),
        ExpensesSectionHeader(
          title: 'Historial Reciente',
          actionLabel: feed.filters.hasFilters ? 'Limpiar' : 'Filtros',
          onAction: onAction,
        ),
      ],
    );
  }

  String _changeLabel(double? ratio) {
    if (ratio == null) return 'Sin referencia del mes anterior';
    final percent = (ratio * 100).abs().toStringAsFixed(0);
    final prefix = ratio >= 0 ? '+' : '-';
    return '$prefix$percent% vs mes anterior';
  }
}
