import 'package:expense_control_app/features/cards/infrastructure/dtos/credit_card_model.dart';
import 'package:isar/isar.dart';

class CreditCardLocalDataSource {
  const CreditCardLocalDataSource(this._isar);

  final Isar _isar;

  Stream<List<CreditCardModel>> watchCards() async* {
    yield await _isar.creditCardModels.where().sortByAlias().findAll();
    yield* _isar.creditCardModels.watchLazy().asyncMap(
      (_) => _isar.creditCardModels.where().sortByAlias().findAll(),
    );
  }

  Future<void> save(CreditCardModel model) async {
    await _isar.writeTxn(() async {
      await _isar.creditCardModels.put(model);
    });
  }
}
