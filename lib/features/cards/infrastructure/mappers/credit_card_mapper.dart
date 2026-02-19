import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';
import 'package:expense_control_app/features/cards/infrastructure/dtos/credit_card_model.dart';
import 'package:isar/isar.dart';

class CreditCardMapper {
  CreditCardEntity toEntity(CreditCardModel model) {
    return CreditCardEntity(
      id: model.id,
      alias: model.alias,
      bank: model.bank,
      last4: model.last4,
      closingDay: model.closingDay,
      dueDay: model.dueDay,
      creditLimit: model.creditLimit,
    );
  }

  CreditCardModel toModel(CreditCardEntity entity) {
    final model = CreditCardModel()
      ..id = entity.id <= 0 ? Isar.autoIncrement : entity.id
      ..alias = entity.alias
      ..bank = entity.bank
      ..last4 = entity.last4
      ..closingDay = entity.closingDay
      ..dueDay = entity.dueDay
      ..creditLimit = entity.creditLimit;

    return model;
  }
}
