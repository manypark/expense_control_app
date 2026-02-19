import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_control_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:expense_control_app/features/expenses/infrastructure/datasource/expense_local_datasource.dart';
import 'package:expense_control_app/features/expenses/infrastructure/mappers/expense_mapper.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  ExpenseRepositoryImpl(this._dataSource, this._mapper);

  final ExpenseLocalDataSource _dataSource;
  final ExpenseMapper _mapper;

  @override
  Future<void> saveExpense(ExpenseEntity expense) {
    return _dataSource.save(_mapper.toModel(expense));
  }

  @override
  Stream<List<ExpenseEntity>> watchExpenses() {
    return _dataSource.watchExpenses().map(
      (models) => models.map(_mapper.toEntity).toList(growable: false),
    );
  }
}
