import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';
import 'package:expense_control_app/features/cards/domain/repositories/credit_card_repository.dart';

class SaveCardUseCase {
  const SaveCardUseCase(this._repository);

  final CreditCardRepository _repository;

  Future<void> call(CreditCardEntity card) => _repository.saveCard(card);
}
