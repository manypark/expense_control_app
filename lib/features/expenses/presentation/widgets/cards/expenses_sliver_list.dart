import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'expense_item_card.dart';

class ExpensesSliverList extends StatelessWidget {
  const ExpensesSliverList({
    super.key,
    required this.expenses,
    required this.cardsById,
    required this.currency,
  });

  final List<ExpenseEntity> expenses;
  final Map<String, CreditCardEntity> cardsById;
  final NumberFormat currency;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final expense = expenses[index];
        return ExpenseItemCard(
          expense: expense,
          cardsById: cardsById,
          amountText: currency.format(expense.amount),
        );
      }, childCount: expenses.length),
    );
  }
}
