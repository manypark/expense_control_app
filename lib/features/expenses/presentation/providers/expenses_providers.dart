import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';
import 'package:expense_control_app/features/cards/presentation/providers/cards_providers.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_control_app/features/expenses/domain/usecases/save_expense_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expenses_providers.g.dart';

@riverpod
AsyncValue<List<ExpenseEntity>> allExpenses(AllExpensesRef ref) {
  return ref.watch(expensesStreamProvider);
}

@riverpod
Map<String, double> monthlyExpenseTotals(MonthlyExpenseTotalsRef ref) {
  final expenses = ref.watch(allExpensesProvider).valueOrNull ?? const [];
  final result = <String, double>{};

  for (final expense in expenses) {
    final key =
        '${expense.incurredAt.year}-${expense.incurredAt.month.toString().padLeft(2, '0')}';
    result[key] = (result[key] ?? 0) + expense.amount;
  }

  return result;
}

@riverpod
Map<String, double> categoryExpenseTotals(CategoryExpenseTotalsRef ref) {
  final expenses = ref.watch(allExpensesProvider).valueOrNull ?? const [];
  final result = <String, double>{};

  for (final expense in expenses) {
    result[expense.category] = (result[expense.category] ?? 0) + expense.amount;
  }

  return result;
}

@riverpod
Map<String, double> cardExpenseTotals(CardExpenseTotalsRef ref) {
  final expenses = ref.watch(allExpensesProvider).valueOrNull ?? const [];
  final result = <String, double>{};

  for (final expense in expenses) {
    final cardId = expense.creditCardId;
    if (cardId == null) continue;
    result[cardId] = (result[cardId] ?? 0) + expense.amount;
  }

  return result;
}

@riverpod
List<ExpenseEntity> expensesForCurrentStatement(
  ExpensesForCurrentStatementRef ref,
) {
  final cards =
      ref.watch(availableCardsProvider).valueOrNull ??
      const <CreditCardEntity>[];
  final expenses = ref.watch(allExpensesProvider).valueOrNull ?? const [];
  final now = DateTime.now();

  final statementKeys = cards.map((card) {
    final cycle = SaveExpenseUseCase.calculateStatementCycle(
      expenseDate: now,
      card: card,
    );
    return (card.id, cycle.statementYear, cycle.statementMonth);
  }).toSet();

  return expenses
      .where((expense) {
        final cardId = expense.creditCardId;
        if (cardId == null) return false;
        return statementKeys.contains((
          cardId,
          expense.statementYear,
          expense.statementMonth,
        ));
      })
      .toList(growable: false);
}
