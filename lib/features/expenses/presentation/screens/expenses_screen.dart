import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_control_app/features/cards/presentation/providers/cards_providers.dart';
import 'package:expense_control_app/features/expenses/presentation/widgets/expense_form_sheet.dart';
import 'package:expense_control_app/features/expenses/presentation/providers/expenses_providers.dart';

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
                  child: Center(child: Text('Aun no hay gastos registrados')),
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
                sliver: SliverList.list(
                  children: [
                    Card(
                      child: ListTile(
                        title: const Text('Gasto del corte actual de tarjetas'),
                        subtitle: const Text(
                          'Este monto depende del dia de cierre configurado por tarjeta',
                        ),
                        trailing: Text(currency.format(statementTotal)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (final expense in expenses)
                      Card(
                        child: ListTile(
                          title: Text(expense.title),
                          subtitle: Text(
                            '${expense.category} | ${DateFormat('dd/MM/yyyy').format(expense.incurredAt)}\n${expense.description}',
                          ),
                          isThreeLine: true,
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(currency.format(expense.amount)),
                              if (expense.creditCardId != null)
                                Text(
                                  cardsById[expense.creditCardId!]?.label ??
                                      'Tarjeta',
                                  style: const TextStyle(fontSize: 11),
                                ),
                            ],
                          ),
                          onTap: expense.receiptPath == null
                              ? null
                              : () =>
                                    _showReceipt(context, expense.receiptPath!),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final cards =
              ref.read(availableCardsProvider).valueOrNull ?? const [];
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (_) => ExpenseFormSheet(cards: cards),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Agregar gasto'),
      ),
    );
  }

  Future<void> _showReceipt(BuildContext context, String path) {
    final isNetwork = path.startsWith('http://') || path.startsWith('https://');

    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ticket guardado'),
          content: isNetwork
              ? Image.network(path, fit: BoxFit.contain)
              : Image.file(File(path), fit: BoxFit.contain),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
