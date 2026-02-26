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
String _$apiClientHash() => r'219d8d073257ec50554a9820cc78a1f6a619b347';

/// See also [apiClient].
@ProviderFor(apiClient)
final apiClientProvider = Provider<HttpClientService>.internal(
  apiClient,
  name: r'apiClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$apiClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ApiClientRef = ProviderRef<HttpClientService>;
String _$accountsStreamHash() => r'5fa1c0eb0683773de317cde35d3421a43a8e233c';

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
String _$cardsStreamHash() => r'978ae9013895f240d6ee2641224b875c421b1720';

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
String _$expensesStreamHash() => r'21bb0ad4b7ed4b97eef60607b415c2c7ddf2861e';

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
String _$authControllerHash() => r'07ff0bca9c8f102645751c78ef12b239cf7294b9';

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
String _$accountCommandsHash() => r'b80c90c88cbfce2a99a0f5273831facbc3b2bbaf';

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
String _$cardCommandsHash() => r'0a0d5cac4a211c8e25ca8d0c3fb9dca4c7013b25';

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
String _$expenseCommandsHash() => r'5f94e325b976dc197a92557e49b0c25e33746701';

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
