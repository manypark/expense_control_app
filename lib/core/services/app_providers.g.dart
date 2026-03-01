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
String _$billsStreamHash() => r'db6d3b22e69e935961708d0e3e5da66dcc7d0cee';

/// See also [billsStream].
@ProviderFor(billsStream)
final billsStreamProvider =
    AutoDisposeFutureProvider<List<BillEntity>>.internal(
  billsStream,
  name: r'billsStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$billsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BillsStreamRef = AutoDisposeFutureProviderRef<List<BillEntity>>;
String _$globalLoadingHash() => r'e2821344b7857b626c571aeb1a58599f427c1e0a';

/// See also [GlobalLoading].
@ProviderFor(GlobalLoading)
final globalLoadingProvider =
    AutoDisposeNotifierProvider<GlobalLoading, bool>.internal(
  GlobalLoading.new,
  name: r'globalLoadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$globalLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GlobalLoading = AutoDisposeNotifier<bool>;
String _$totalAmountVisibilityHash() =>
    r'9c8c8cba8b60330550cdf185a8e2e2c87bdacf52';

/// See also [TotalAmountVisibility].
@ProviderFor(TotalAmountVisibility)
final totalAmountVisibilityProvider =
    AutoDisposeAsyncNotifierProvider<TotalAmountVisibility, bool>.internal(
  TotalAmountVisibility.new,
  name: r'totalAmountVisibilityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalAmountVisibilityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TotalAmountVisibility = AutoDisposeAsyncNotifier<bool>;
String _$authControllerHash() => r'd89c43342221513d5e91409654ebc2e54082495e';

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
String _$accountCommandsHash() => r'1c5e9ffd1f2e773a1765537c0fc9c966550cbb55';

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
String _$expenseCommandsHash() => r'f715cd7549b64f3091ff9cc7dcd870be454440aa';

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
String _$billCommandsHash() => r'ea8ea97eaf33d00ae20c6075103553366d81e303';

/// See also [BillCommands].
@ProviderFor(BillCommands)
final billCommandsProvider =
    AutoDisposeNotifierProvider<BillCommands, void>.internal(
  BillCommands.new,
  name: r'billCommandsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$billCommandsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BillCommands = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
