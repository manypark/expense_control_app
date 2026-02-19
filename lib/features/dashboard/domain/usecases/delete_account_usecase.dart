import 'package:expense_control_app/features/dashboard/domain/repositories/money_account_repository.dart';

class DeleteAccountUseCase {
  const DeleteAccountUseCase(this._repository);

  final MoneyAccountRepository _repository;

  Future<void> call(int accountId) => _repository.deleteAccount(accountId);
}
