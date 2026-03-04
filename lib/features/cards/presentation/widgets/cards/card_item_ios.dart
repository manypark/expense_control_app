import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expense_control_app/features/cards/domain/entities/entities.dart';

class CardItemIos extends StatelessWidget {
  const CardItemIos({
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
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color       : Colors.black12.withAlpha(10),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.credit_card_outlined),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.label,
                    style: TextStyle(
                      color: CupertinoColors.label.resolveFrom(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${card.bank} · Cierre ${card.closingDay} · Pago ${card.dueDay}',
                    style: TextStyle(
                      color: CupertinoColors.secondaryLabel.resolveFrom(
                        context,
                      ),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              limitText,
              style: TextStyle(
                color: CupertinoColors.label.resolveFrom(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
