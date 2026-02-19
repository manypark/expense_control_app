import 'package:expense_control_app/features/cards/infrastructure/dtos/credit_card_model.dart';
import 'package:expense_control_app/features/dashboard/infrastructure/dtos/money_account_model.dart';
import 'package:expense_control_app/features/expenses/infrastructure/dtos/expense_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  const IsarService();

  Future<Isar> open() async {
    final directory = await getApplicationDocumentsDirectory();

    return Isar.open(
      [MoneyAccountModelSchema, CreditCardModelSchema, ExpenseModelSchema],
      directory: directory.path,
      name: 'expense_control_db',
    );
  }
}
