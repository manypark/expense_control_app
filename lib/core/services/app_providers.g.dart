// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isarHash() => r'e5d33c6b183e1f1b88172a32c0d206c40743ca2a';

/// See also [isar].
@ProviderFor(isar)
final isarProvider = FutureProvider<Isar>.internal(
  isar,
  name: r'isarProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isarHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsarRef = FutureProviderRef<Isar>;
String _$moneyAccountRepositoryHash() =>
    r'89aebd35e4f4046ac711a20c93390d6d9c93ce62';

/// See also [moneyAccountRepository].
@ProviderFor(moneyAccountRepository)
final moneyAccountRepositoryProvider =
    AutoDisposeFutureProvider<MoneyAccountRepository>.internal(
      moneyAccountRepository,
      name: r'moneyAccountRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$moneyAccountRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef MoneyAccountRepositoryRef =
    AutoDisposeFutureProviderRef<MoneyAccountRepository>;
String _$accountsStreamHash() => r'1ee7e980dc361a8d7079a8861ae1550ff54f071f';

/// See also [accountsStream].
@ProviderFor(accountsStream)
final accountsStreamProvider =
    AutoDisposeStreamProvider<List<MoneyAccountEntity>>.internal(
      accountsStream,
      name: r'accountsStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$accountsStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef AccountsStreamRef =
    AutoDisposeStreamProviderRef<List<MoneyAccountEntity>>;
String _$creditCardRepositoryHash() =>
    r'c25292cb024dc058ac566ae7e7835af64e261f8c';

/// See also [creditCardRepository].
@ProviderFor(creditCardRepository)
final creditCardRepositoryProvider =
    AutoDisposeFutureProvider<CreditCardRepository>.internal(
      creditCardRepository,
      name: r'creditCardRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$creditCardRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef CreditCardRepositoryRef =
    AutoDisposeFutureProviderRef<CreditCardRepository>;
String _$cardsStreamHash() => r'3de4d3af44cee53e78f59601c8d5f562f8df781d';

/// See also [cardsStream].
@ProviderFor(cardsStream)
final cardsStreamProvider =
    AutoDisposeStreamProvider<List<CreditCardEntity>>.internal(
      cardsStream,
      name: r'cardsStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cardsStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef CardsStreamRef = AutoDisposeStreamProviderRef<List<CreditCardEntity>>;
String _$expenseRepositoryHash() => r'6a551e5d1f6e00794fbae58ad90122e03cdbef8b';

/// See also [expenseRepository].
@ProviderFor(expenseRepository)
final expenseRepositoryProvider =
    AutoDisposeFutureProvider<ExpenseRepository>.internal(
      expenseRepository,
      name: r'expenseRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$expenseRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef ExpenseRepositoryRef = AutoDisposeFutureProviderRef<ExpenseRepository>;
String _$expensesStreamHash() => r'62884cd21a17eec9d6ee303a87c341862baa97ac';

/// See also [expensesStream].
@ProviderFor(expensesStream)
final expensesStreamProvider =
    AutoDisposeStreamProvider<List<ExpenseEntity>>.internal(
      expensesStream,
      name: r'expensesStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$expensesStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef ExpensesStreamRef = AutoDisposeStreamProviderRef<List<ExpenseEntity>>;
String _$accountCommandsHash() => r'83b0c4f6e3bf435540be124e62c5d9cd5687707c';

/// See also [AccountCommands].
@ProviderFor(AccountCommands)
final accountCommandsProvider =
    AutoDisposeNotifierProvider<AccountCommands, void>.internal(
      AccountCommands.new,
      name: r'accountCommandsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$accountCommandsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AccountCommands = AutoDisposeNotifier<void>;
String _$cardCommandsHash() => r'26d4c630829927934fb83cb46493bd16b638aa8c';

/// See also [CardCommands].
@ProviderFor(CardCommands)
final cardCommandsProvider =
    AutoDisposeNotifierProvider<CardCommands, void>.internal(
      CardCommands.new,
      name: r'cardCommandsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cardCommandsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CardCommands = AutoDisposeNotifier<void>;
String _$expenseCommandsHash() => r'68e9c5dad41cc2301f8b27b89bdcc79fd4279ebb';

/// See also [ExpenseCommands].
@ProviderFor(ExpenseCommands)
final expenseCommandsProvider =
    AutoDisposeNotifierProvider<ExpenseCommands, void>.internal(
      ExpenseCommands.new,
      name: r'expenseCommandsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$expenseCommandsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ExpenseCommands = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
