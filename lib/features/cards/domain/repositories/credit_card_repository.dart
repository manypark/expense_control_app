import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';

abstract class CreditCardRepository {
  Stream<List<CreditCardEntity>> watchCards();
  Future<void> saveCard(CreditCardEntity card);
}
