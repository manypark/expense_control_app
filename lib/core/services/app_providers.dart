import 'dart:async';

import 'package:expense_control_app/core/services/isar_service.dart';
import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';
import 'package:expense_control_app/features/cards/domain/repositories/credit_card_repository.dart';
import 'package:expense_control_app/features/cards/domain/usecases/save_card_usecase.dart';
import 'package:expense_control_app/features/cards/domain/usecases/watch_cards_usecase.dart';
import 'package:expense_control_app/features/cards/infrastructure/datasource/credit_card_local_datasource.dart';
import 'package:expense_control_app/features/cards/infrastructure/mappers/credit_card_mapper.dart';
import 'package:expense_control_app/features/cards/infrastructure/repositories/credit_card_repository_impl.dart';
import 'package:expense_control_app/features/dashboard/domain/entities/money_account.dart';
import 'package:expense_control_app/features/dashboard/domain/repositories/money_account_repository.dart';
import 'package:expense_control_app/features/dashboard/domain/usecases/delete_account_usecase.dart';
import 'package:expense_control_app/features/dashboard/domain/usecases/upsert_account_usecase.dart';
import 'package:expense_control_app/features/dashboard/domain/usecases/watch_accounts_usecase.dart';
import 'package:expense_control_app/features/dashboard/infrastructure/datasource/money_account_local_datasource.dart';
import 'package:expense_control_app/features/dashboard/infrastructure/mappers/money_account_mapper.dart';
import 'package:expense_control_app/features/dashboard/infrastructure/repositories/money_account_repository_impl.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_control_app/features/expenses/domain/repositories/expense_repository.dart';
import 'package:expense_control_app/features/expenses/domain/usecases/save_expense_usecase.dart';
import 'package:expense_control_app/features/expenses/domain/usecases/watch_expenses_usecase.dart';
import 'package:expense_control_app/features/expenses/infrastructure/datasource/expense_local_datasource.dart';
import 'package:expense_control_app/features/expenses/infrastructure/mappers/expense_mapper.dart';
import 'package:expense_control_app/features/expenses/infrastructure/repositories/expense_repository_impl.dart';
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
  FutureOr<void> build() {}

  Future<void> upsertAccount(MoneyAccountEntity account) async {
    state = const AsyncLoading();
    try {
      final repository = await ref.read(moneyAccountRepositoryProvider.future);
      await UpsertAccountUseCase(repository)(account);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> deleteAccount(int accountId) async {
    state = const AsyncLoading();
    try {
      final repository = await ref.read(moneyAccountRepositoryProvider.future);
      await DeleteAccountUseCase(repository)(accountId);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
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
  FutureOr<void> build() {}

  Future<void> saveCard(CreditCardEntity card) async {
    state = const AsyncLoading();
    try {
      final repository = await ref.read(creditCardRepositoryProvider.future);
      await SaveCardUseCase(repository)(card);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
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
  FutureOr<void> build() {}

  Future<void> saveExpense(ExpenseEntity expense) async {
    state = const AsyncLoading();
    try {
      final repository = await ref.read(expenseRepositoryProvider.future);
      await SaveExpenseUseCase(repository)(expense);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
