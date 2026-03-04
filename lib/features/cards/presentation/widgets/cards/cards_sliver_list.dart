import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_control_app/features/cards/domain/entities/entities.dart';

import 'card_item_ios.dart';
import 'card_item_material.dart';

class CardsSliverList extends StatelessWidget {
  const CardsSliverList({
    super.key,
    required this.cards,
    required this.currency,
    required this.onTap,
  });

  final List<CreditCardEntity> cards;
  final NumberFormat currency;
  final void Function(CreditCardEntity card) onTap;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final card = cards[index];
          final limitText = currency.format(card.creditLimit);

          if (isIOS) {
            return CardItemIos(
              card: card,
              limitText: limitText,
              onTap: () => onTap(card),
            );
          }

          return CardItemMaterial(
            card: card,
            limitText: limitText,
            onTap: () => onTap(card),
          );
        }, childCount: cards.length),
      ),
    );
  }
}
