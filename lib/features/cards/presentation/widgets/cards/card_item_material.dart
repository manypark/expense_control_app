import 'package:flutter/material.dart';

import 'package:expense_control_app/features/cards/domain/entities/entities.dart';

class CardItemMaterial extends StatelessWidget {
  const CardItemMaterial({
    super.key,
    required this.card,
    required this.limitText,
    required this.onTap,
  });

  final CreditCardEntity card;
  final String limitText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(card.label),
        subtitle: Text(
          '${card.bank} | Cierre ${card.closingDay} | Pago ${card.dueDay}',
        ),
        trailing: Text(limitText),
        onTap: onTap,
      ),
    );
  }
}
