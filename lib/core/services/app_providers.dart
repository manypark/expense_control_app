import 'dart:async';

import 'package:expense_control_app/core/services/isar_service.dart';
import 'package:expense_control_app/features/cards/domain/domain.dart';
import 'package:expense_control_app/features/cards/infrastructure/infrastructure.dart';
import 'package:expense_control_app/features/dashboard/domain/domain.dart';
import 'package:expense_control_app/features/dashboard/infrastructure/infrastructure.dart';
import 'package:expense_control_app/features/expenses/domain/domain.dart';
import 'package:expense_control_app/features/expenses/infrastructure/infrastructure.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isar(IsarRef ref) {
  return const IsarService().open();
}

@riverpod
Future<MoneyAccountRepository> moneyAccountRepository(
  MoneyAccountRepositoryRef ref,
) async {
  final isarDb = await ref.watch(isarProvider.future);
  return MoneyAccountRepositoryImpl(
    MoneyAccountLocalDataSource(isarDb),
    MoneyAccountMapper(),
  );
}

@riverpod
Stream<List<MoneyAccountEntity>> accountsStream(AccountsStreamRef ref) async* {
  final repository = await ref.watch(moneyAccountRepositoryProvider.future);
  await repository.ensureDefaultAccounts();
  yield* WatchAccountsUseCase(repository)();
}

@riverpod
class AccountCommands extends _$AccountCommands {
  @override
  void build() {}

  Future<void> upsertAccount(MoneyAccountEntity account) async {
    final repository = await ref.read(moneyAccountRepositoryProvider.future);
    await UpsertAccountUseCase(repository)(account);
  }

  Future<void> deleteAccount(int accountId) async {
    final repository = await ref.read(moneyAccountRepositoryProvider.future);
    await DeleteAccountUseCase(repository)(accountId);
  }
}

@riverpod
Future<CreditCardRepository> creditCardRepository(
  CreditCardRepositoryRef ref,
) async {
  final isarDb = await ref.watch(isarProvider.future);
  return CreditCardRepositoryImpl(
    CreditCardLocalDataSource(isarDb),
    CreditCardMapper(),
  );
}

@riverpod
Stream<List<CreditCardEntity>> cardsStream(CardsStreamRef ref) async* {
  final repository = await ref.watch(creditCardRepositoryProvider.future);
  yield* WatchCardsUseCase(repository)();
}

@riverpod
class CardCommands extends _$CardCommands {
  @override
  void build() {}

  Future<void> saveCard(CreditCardEntity card) async {
    final repository = await ref.read(creditCardRepositoryProvider.future);
    await SaveCardUseCase(repository)(card);
  }
}

@riverpod
Future<ExpenseRepository> expenseRepository(ExpenseRepositoryRef ref) async {
  final isarDb = await ref.watch(isarProvider.future);
  return ExpenseRepositoryImpl(ExpenseLocalDataSource(isarDb), ExpenseMapper());
}

@riverpod
Stream<List<ExpenseEntity>> expensesStream(ExpensesStreamRef ref) async* {
  final repository = await ref.watch(expenseRepositoryProvider.future);
  yield* WatchExpensesUseCase(repository)();
}

@riverpod
class ExpenseCommands extends _$ExpenseCommands {
  @override
  void build() {}

  Future<void> saveExpense(ExpenseEntity expense) async {
    final repository = await ref.read(expenseRepositoryProvider.future);
    await SaveExpenseUseCase(repository)(expense);
  }
}
