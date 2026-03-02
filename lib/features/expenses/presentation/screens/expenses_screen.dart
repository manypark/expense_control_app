import 'package:expense_control_app/features/cards/presentation/providers/cards_providers.dart';
import 'package:expense_control_app/features/expenses/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(allExpensesProvider);
    final cardsById = ref.watch(cardsByIdProvider);
    final statementExpenses = ref.watch(expensesForCurrentStatementProvider);
    final currency = NumberFormat.currency(locale: 'es_MX', symbol: r'$');

    return Scaffold(
      body: expensesAsync.when(
        data: (expenses) {
          if (expenses.isEmpty) {
            return const CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: [
                SliverAppBar(pinned: true, title: Text('Gastos')),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: EmptyExpensesText()),
                ),
              ],
            );
          }

          final statementTotal = statementExpenses.fold<double>(
            0,
            (sum, expense) => sum + expense.amount,
          );

          return CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              const SliverAppBar(pinned: true, title: Text('Gastos')),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      StatementTotalCard(
                        totalText: currency.format(statementTotal),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: ExpensesSliverList(
                  expenses: expenses,
                  cardsById: cardsById,
                  currency: currency,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: AddExpenseFab(
        onPressed: () => _openExpenseForm(context, ref),
      ),
    );
  }

  void _openExpenseForm(BuildContext context, WidgetRef ref) {
    final cards = ref.read(availableCardsProvider).valueOrNull ?? const [];
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ExpenseFormSheet(cards: cards),
    );
  }
}
