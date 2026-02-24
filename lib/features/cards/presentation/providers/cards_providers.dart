import 'package:expense_control_app/core/services/app_providers.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';

part 'cards_providers.g.dart';

@riverpod
AsyncValue<List<CreditCardEntity>> availableCards(AvailableCardsRef ref) {
  return ref.watch(cardsStreamProvider);
}

@riverpod
Map<String, CreditCardEntity> cardsById(CardsByIdRef ref) {
  final cards = ref.watch(availableCardsProvider).valueOrNull ?? const [];
  return {for (final card in cards) card.id: card};
}
