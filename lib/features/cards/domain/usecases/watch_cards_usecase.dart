import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';
import 'package:expense_control_app/features/cards/domain/repositories/credit_card_repository.dart';

class WatchCardsUseCase {
  const WatchCardsUseCase(this._repository);

  final CreditCardRepository _repository;

  Stream<List<CreditCardEntity>> call() => _repository.watchCards();
}
