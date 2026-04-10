import 'package:flutter/material.dart';

import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';

import 'expense_item_card.dart';

class ExpenseItemTileIos extends StatelessWidget {
  const ExpenseItemTileIos({
    super.key,
    required this.expense,
    required this.cardsById,
    required this.amountText,
    required this.onEdit,
    required this.onDelete,
  });

  final String amountText;
  final ExpenseEntity expense;
  final Map<String, CreditCardEntity> cardsById;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ExpenseItemCard(
      expense: expense,
      cardsById: cardsById,
      amountText: amountText,
      onEdit: onEdit,
      onDelete: onDelete,
    );
  }
}
