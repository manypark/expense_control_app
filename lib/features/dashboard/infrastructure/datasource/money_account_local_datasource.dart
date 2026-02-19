import 'package:expense_control_app/core/constants/app_constants.dart';
import 'package:expense_control_app/features/dashboard/infrastructure/dtos/money_account_model.dart';
import 'package:isar/isar.dart';

class MoneyAccountLocalDataSource {
  const MoneyAccountLocalDataSource(this._isar);

  final Isar _isar;

  Stream<List<MoneyAccountModel>> watchAccounts() async* {
    yield await _isar.moneyAccountModels.where().sortByName().findAll();
    yield* _isar.moneyAccountModels.watchLazy().asyncMap(
      (_) => _isar.moneyAccountModels.where().sortByName().findAll(),
    );
  }

  Future<void> upsert(MoneyAccountModel model) async {
    await _isar.writeTxn(() async {
      await _isar.moneyAccountModels.put(model);
    });
  }

  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.moneyAccountModels.delete(id);
    });
  }

  Future<void> ensureDefaultAccounts() async {
    final existing = await _isar.moneyAccountModels.where().findAll();
    if (existing.isNotEmpty) return;

    final models = AppConstants.defaultMoneyAccounts
        .map(
          (seed) => MoneyAccountModel()
            ..code = seed.code
            ..name = seed.name
            ..balance = 0,
        )
        .toList(growable: false);

    await _isar.writeTxn(() async {
      await _isar.moneyAccountModels.putAll(models);
    });
  }
}
