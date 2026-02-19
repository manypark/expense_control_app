import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_control_app/features/expenses/domain/repositories/expense_repository.dart';

class SaveExpenseUseCase {
  const SaveExpenseUseCase(this._repository);

  final ExpenseRepository _repository;

  Future<void> call(ExpenseEntity expense) => _repository.saveExpense(expense);

  static ({int statementYear, int statementMonth}) calculateStatementCycle({
    required DateTime expenseDate,
    required CreditCardEntity card,
  }) {
    final month = expenseDate.month;
    final year = expenseDate.year;

    if (expenseDate.day <= card.closingDay) {
      return (statementYear: year, statementMonth: month);
    }

    if (month == 12) {
      return (statementYear: year + 1, statementMonth: 1);
    }

    return (statementYear: year, statementMonth: month + 1);
  }
}
