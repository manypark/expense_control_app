import 'package:expense_control_app/features/dashboard/domain/entities/money_account.dart';
import 'package:expense_control_app/features/dashboard/infrastructure/dtos/money_account_model.dart';
import 'package:isar/isar.dart';

class MoneyAccountMapper {
  MoneyAccountEntity toEntity(MoneyAccountModel model) {
    return MoneyAccountEntity(
      id: model.id,
      code: model.code,
      name: model.name,
      balance: model.balance,
    );
  }

  MoneyAccountModel toModel(MoneyAccountEntity entity) {
    final model = MoneyAccountModel()
      ..id = entity.id <= 0 ? Isar.autoIncrement : entity.id
      ..code = entity.code
      ..name = entity.name
      ..balance = entity.balance;

    return model;
  }
}
