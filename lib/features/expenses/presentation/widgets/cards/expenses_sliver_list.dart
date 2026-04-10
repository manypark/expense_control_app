import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'expense_item_card.dart';
import 'expense_item_tile_ios.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';

class ExpensesSliverList extends StatelessWidget {
  final NumberFormat currency;
  final List<ExpenseEntity> expenses;
  final Map<String, CreditCardEntity> cardsById;
  final void Function(ExpenseEntity expense) onEdit;
  final void Function(ExpenseEntity expense) onDelete;
  final bool isLoadingMore;
  const ExpensesSliverList({
    super.key,
    required this.expenses,
    required this.cardsById,
    required this.currency,
    required this.onEdit,
    required this.onDelete,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index >= expenses.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final expense = expenses[index];
        final amountText = currency.format(expense.amount);

        if (isIOS) {
          return ExpenseItemTileIos(
            expense: expense,
            cardsById: cardsById,
            amountText: amountText,
            onEdit: () => onEdit(expense),
            onDelete: () => onDelete(expense),
          );
        }
        return ExpenseItemCard(
          expense: expense,
          cardsById: cardsById,
          amountText: amountText,
          onEdit: () => onEdit(expense),
          onDelete: () => onDelete(expense),
        );
      }, childCount: expenses.length + (isLoadingMore ? 1 : 0)),
    );
  }
}
