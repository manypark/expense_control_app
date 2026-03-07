import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';

class ExpenseItemCard extends StatelessWidget {

  final String amountText;
  final ExpenseEntity expense;
  final VoidCallback onDelete;
  final Map<String, CreditCardEntity> cardsById;

  const ExpenseItemCard({
    super.key,
    required this.expense,
    required this.cardsById,
    required this.amountText,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    final subtitle = '${expense.category} | ${DateFormat('dd/MM/yyyy').format(expense.incurredAt)}\n${expense.description}';

    return Card(
      child: ListTile(
        title       : Text(expense.title),
        subtitle    : Text(subtitle),
        trailing    : Row(
          mainAxisSize      : MainAxisSize.min,
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing           : 32,
          children          : [

            Column(
              mainAxisSize      : MainAxisSize.min,
              mainAxisAlignment : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children          : [
                Text(amountText),
                if (expense.creditCardId != null)
                  Text(
                    cardsById[expense.creditCardId!]?.label ?? 'Tarjeta',
                    style: const TextStyle(fontSize: 11),
                  ),
              ],
            ),

            InkWell(
              onTap       : onDelete,
              borderRadius: BorderRadius.circular(12),
              child       : const Padding(
                padding : EdgeInsets.all(2),
                child   : Icon( Icons.delete_outline, size: 28 ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
