import 'package:expense_control_app/features/expenses/infrastructure/dtos/expense_model.dart';
import 'package:isar/isar.dart';

class ExpenseLocalDataSource {
  const ExpenseLocalDataSource(this._isar);

  final Isar _isar;

  Stream<List<ExpenseModel>> watchExpenses() async* {
    yield await _isar.expenseModels.where().sortByIncurredAtDesc().findAll();
    yield* _isar.expenseModels.watchLazy().asyncMap(
      (_) => _isar.expenseModels.where().sortByIncurredAtDesc().findAll(),
    );
  }

  Future<void> save(ExpenseModel model) async {
    await _isar.writeTxn(() async {
      await _isar.expenseModels.put(model);
    });
  }
}
