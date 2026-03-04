import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:expense_control_app/features/cards/domain/entities/entities.dart';
import 'package:expense_control_app/features/cards/presentation/providers/providers.dart';
import 'package:expense_control_app/features/cards/presentation/widgets/widgets.dart';

class CardsScreen extends ConsumerWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsAsync = ref.watch(availableCardsProvider);
    final currency = NumberFormat.currency(locale: 'es_MX', symbol: r'$');

    return Scaffold(
      body: cardsAsync.when(
        data: (cards) {
          return CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              _CardsAppBar(onAdd: () => _openForm(context)),
              if (cards.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: EmptyCardsText()),
                )
              else
                CardsSliverList(
                  cards: cards,
                  currency: currency,
                  onTap: (card) => _openForm(context, card: card),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _openForm(BuildContext context, {CreditCardEntity? card}) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final form = CardFormSheet(card: card);

    if (isIOS) {
      showCupertinoModalPopup<void>(
        context: context,
        barrierDismissible: true,
        builder: (_) => SafeArea(
          top: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: CupertinoColors.systemBackground.resolveFrom(context),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              clipBehavior: Clip.antiAlias,
              child: form,
            ),
          ),
        ),
      );
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => form,
    );
  }
}

class _CardsAppBar extends StatelessWidget {
  const _CardsAppBar({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      return CupertinoSliverNavigationBar(
        largeTitle: const Text('Tarjetas'),
        trailing: AddCardAppBarButton(onPressed: onAdd),
      );
    }

    return SliverAppBar(
      pinned: true,
      title: const Text('Tarjetas'),
      actions: [AddCardAppBarButton(onPressed: onAdd)],
    );
  }
}
