// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dashboardAccountsHash() => r'c2c537e7de9e341c2658625f093b503d4616b64a';

/// See also [dashboardAccounts].
@ProviderFor(dashboardAccounts)
final dashboardAccountsProvider =
    AutoDisposeProvider<AsyncValue<List<MoneyAccountEntity>>>.internal(
      dashboardAccounts,
      name: r'dashboardAccountsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dashboardAccountsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef DashboardAccountsRef =
    AutoDisposeProviderRef<AsyncValue<List<MoneyAccountEntity>>>;
String _$totalMoneyHash() => r'b001fb69132fa94a468bf09ac9cef11005a963d4';

/// See also [totalMoney].
@ProviderFor(totalMoney)
final totalMoneyProvider = AutoDisposeProvider<double>.internal(
  totalMoney,
  name: r'totalMoneyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalMoneyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TotalMoneyRef = AutoDisposeProviderRef<double>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
