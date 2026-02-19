import 'package:expense_control_app/features/dashboard/domain/entities/money_account.dart';

abstract class MoneyAccountRepository {
  Stream<List<MoneyAccountEntity>> watchAccounts();
  Future<void> upsertAccount(MoneyAccountEntity account);
  Future<void> deleteAccount(int accountId);
  Future<void> ensureDefaultAccounts();
}
