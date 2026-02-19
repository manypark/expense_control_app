import 'package:expense_control_app/features/dashboard/domain/entities/money_account.dart';
import 'package:expense_control_app/features/dashboard/domain/repositories/money_account_repository.dart';

class UpsertAccountUseCase {
  const UpsertAccountUseCase(this._repository);

  final MoneyAccountRepository _repository;

  Future<void> call(MoneyAccountEntity account) =>
      _repository.upsertAccount(account);
}
