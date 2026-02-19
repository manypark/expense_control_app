import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_control_app/features/expenses/domain/repositories/expense_repository.dart';

class WatchExpensesUseCase {
  const WatchExpensesUseCase(this._repository);

  final ExpenseRepository _repository;

  Stream<List<ExpenseEntity>> call() => _repository.watchExpenses();
}
