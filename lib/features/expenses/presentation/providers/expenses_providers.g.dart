// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allExpensesHash() => r'b673594a0a1097a42637b35847250249f754c826';

/// See also [allExpenses].
@ProviderFor(allExpenses)
final allExpensesProvider =
    AutoDisposeProvider<AsyncValue<List<ExpenseEntity>>>.internal(
  allExpenses,
  name: r'allExpensesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allExpensesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllExpensesRef
    = AutoDisposeProviderRef<AsyncValue<List<ExpenseEntity>>>;
String _$monthlyExpenseTotalsHash() =>
    r'60e6331a9328ab0c6a4649935c32b88df120f325';

/// See also [monthlyExpenseTotals].
@ProviderFor(monthlyExpenseTotals)
final monthlyExpenseTotalsProvider =
    AutoDisposeProvider<Map<String, double>>.internal(
  monthlyExpenseTotals,
  name: r'monthlyExpenseTotalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$monthlyExpenseTotalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MonthlyExpenseTotalsRef = AutoDisposeProviderRef<Map<String, double>>;
String _$categoryExpenseTotalsHash() =>
    r'002ed43565cbd4a8fcec83998aaf181e942e1d29';

/// See also [categoryExpenseTotals].
@ProviderFor(categoryExpenseTotals)
final categoryExpenseTotalsProvider =
    AutoDisposeProvider<Map<String, double>>.internal(
  categoryExpenseTotals,
  name: r'categoryExpenseTotalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryExpenseTotalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CategoryExpenseTotalsRef = AutoDisposeProviderRef<Map<String, double>>;
String _$cardExpenseTotalsHash() => r'811e3345ea3ad53cf6a1f8aa69cf03073f5afde5';

/// See also [cardExpenseTotals].
@ProviderFor(cardExpenseTotals)
final cardExpenseTotalsProvider =
    AutoDisposeProvider<Map<String, double>>.internal(
  cardExpenseTotals,
  name: r'cardExpenseTotalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cardExpenseTotalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CardExpenseTotalsRef = AutoDisposeProviderRef<Map<String, double>>;
String _$expensesForCurrentStatementHash() =>
    r'4f82c94194b06ce40293684b5d477fb72f812431';

/// See also [expensesForCurrentStatement].
@ProviderFor(expensesForCurrentStatement)
final expensesForCurrentStatementProvider =
    AutoDisposeProvider<List<ExpenseEntity>>.internal(
  expensesForCurrentStatement,
  name: r'expensesForCurrentStatementProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expensesForCurrentStatementHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExpensesForCurrentStatementRef
    = AutoDisposeProviderRef<List<ExpenseEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
