import 'package:expense_control_app/features/dashboard/domain/entities/money_account.dart';
import 'package:expense_control_app/features/dashboard/infrastructure/dtos/money_account_model.dart';
import 'package:isar/isar.dart';

class MoneyAccountMapper {
  MoneyAccountEntity toEntity(MoneyAccountModel model) {
    return MoneyAccountEntity(
      id: model.id.toString(),
      code: model.code,
      name: model.name,
      balance: model.balance,
    );
  }

  MoneyAccountModel toModel(MoneyAccountEntity entity) {
    final parsedId = int.tryParse(entity.id);
    final model = MoneyAccountModel()
      ..id = (parsedId == null || parsedId <= 0) ? Isar.autoIncrement : parsedId
      ..code = entity.code
      ..name = entity.name
      ..balance = entity.balance;

    return model;
  }
}
