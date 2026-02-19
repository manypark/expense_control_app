import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';

abstract class ExpenseRepository {
  Stream<List<ExpenseEntity>> watchExpenses();
  Future<void> saveExpense(ExpenseEntity expense);
}
