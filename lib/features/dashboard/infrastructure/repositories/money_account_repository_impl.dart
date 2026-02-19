import 'package:expense_control_app/features/dashboard/domain/entities/money_account.dart';
import 'package:expense_control_app/features/dashboard/domain/repositories/money_account_repository.dart';
import 'package:expense_control_app/features/dashboard/infrastructure/datasource/money_account_local_datasource.dart';
import 'package:expense_control_app/features/dashboard/infrastructure/mappers/money_account_mapper.dart';

class MoneyAccountRepositoryImpl implements MoneyAccountRepository {
  MoneyAccountRepositoryImpl(this._dataSource, this._mapper);

  final MoneyAccountLocalDataSource _dataSource;
  final MoneyAccountMapper _mapper;

  @override
  Future<void> ensureDefaultAccounts() {
    return _dataSource.ensureDefaultAccounts();
  }

  @override
  Future<void> upsertAccount(MoneyAccountEntity account) {
    return _dataSource.upsert(_mapper.toModel(account));
  }

  @override
  Future<void> deleteAccount(int accountId) {
    return _dataSource.delete(accountId);
  }

  @override
  Stream<List<MoneyAccountEntity>> watchAccounts() {
    return _dataSource.watchAccounts().map(
      (models) => models.map(_mapper.toEntity).toList(growable: false),
    );
  }
}
