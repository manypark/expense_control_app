import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItemCard extends StatelessWidget {
  const ExpenseItemCard({
    super.key,
    required this.expense,
    required this.cardsById,
    required this.amountText,
  });

  final ExpenseEntity expense;
  final Map<String, CreditCardEntity> cardsById;
  final String amountText;

  @override
  Widget build(BuildContext context) {
    final subtitle =
        '${expense.category} | ${DateFormat('dd/MM/yyyy').format(expense.incurredAt)}\n${expense.description}';

    return Card(
      child: ListTile(
        title: Text(expense.title),
        subtitle: Text(subtitle),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(amountText),
            if (expense.creditCardId != null)
              Text(
                cardsById[expense.creditCardId!]?.label ?? 'Tarjeta',
                style: const TextStyle(fontSize: 11),
              ),
          ],
        ),
      ),
    );
  }
}
