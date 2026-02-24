// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiBaseUrlHash() => r'f440ac1d8c3711b1c32a1a174e2ebc8e4f198e8d';

/// See also [apiBaseUrl].
@ProviderFor(apiBaseUrl)
final apiBaseUrlProvider = Provider<String>.internal(
  apiBaseUrl,
  name: r'apiBaseUrlProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$apiBaseUrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ApiBaseUrlRef = ProviderRef<String>;
String _$apiClientHash() => r'483fc729f737a595c5c5de410b71905eb575fce5';

/// See also [apiClient].
@ProviderFor(apiClient)
final apiClientProvider = Provider<ApiClient>.internal(
  apiClient,
  name: r'apiClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$apiClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ApiClientRef = ProviderRef<ApiClient>;
String _$accountsStreamHash() => r'348d3e6f8d70a22f5b75be89b4ec5bf2d435bd7a';

/// See also [accountsStream].
@ProviderFor(accountsStream)
final accountsStreamProvider =
    AutoDisposeFutureProvider<List<MoneyAccountEntity>>.internal(
  accountsStream,
  name: r'accountsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accountsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AccountsStreamRef
    = AutoDisposeFutureProviderRef<List<MoneyAccountEntity>>;
String _$cardsStreamHash() => r'4b456e8d7f2a3b590fbfd00f197c86033abf6642';

/// See also [cardsStream].
@ProviderFor(cardsStream)
final cardsStreamProvider =
    AutoDisposeFutureProvider<List<CreditCardEntity>>.internal(
  cardsStream,
  name: r'cardsStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cardsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CardsStreamRef = AutoDisposeFutureProviderRef<List<CreditCardEntity>>;
String _$expensesStreamHash() => r'48eb2f69670ad1b097f8f61aaf97791615148f77';

/// See also [expensesStream].
@ProviderFor(expensesStream)
final expensesStreamProvider =
    AutoDisposeFutureProvider<List<ExpenseEntity>>.internal(
  expensesStream,
  name: r'expensesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expensesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExpensesStreamRef = AutoDisposeFutureProviderRef<List<ExpenseEntity>>;
String _$authControllerHash() => r'8d1fb800024b7742f70943415833c68337c8949a';

/// See also [AuthController].
@ProviderFor(AuthController)
final authControllerProvider =
    AutoDisposeAsyncNotifierProvider<AuthController, AuthSession?>.internal(
  AuthController.new,
  name: r'authControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthController = AutoDisposeAsyncNotifier<AuthSession?>;
String _$accountCommandsHash() => r'440f1543f4dd64fc0646cd75394f067e29a0ba75';

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
String _$cardCommandsHash() => r'5971db9ef4b31e35abf5bf02a8a2b37a67008a8f';

/// See also [CardCommands].
@ProviderFor(CardCommands)
final cardCommandsProvider =
    AutoDisposeNotifierProvider<CardCommands, void>.internal(
  CardCommands.new,
  name: r'cardCommandsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cardCommandsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CardCommands = AutoDisposeNotifier<void>;
String _$expenseCommandsHash() => r'53b23c3a66e63c6781df7868610c9341bba030cb';

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
