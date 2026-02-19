import 'package:expense_control_app/features/dashboard/domain/entities/money_account.dart';
import 'package:expense_control_app/features/dashboard/domain/repositories/money_account_repository.dart';

class WatchAccountsUseCase {
  const WatchAccountsUseCase(this._repository);

  final MoneyAccountRepository _repository;

  Stream<List<MoneyAccountEntity>> call() => _repository.watchAccounts();
}
