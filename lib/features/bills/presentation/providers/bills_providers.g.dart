// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bills_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allBillsHash() => r'769c1d0e54fe17a35fd903f1530b8eafe6529d1c';

/// See also [allBills].
@ProviderFor(allBills)
final allBillsProvider = AutoDisposeFutureProvider<List<BillEntity>>.internal(
  allBills,
  name: r'allBillsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allBillsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllBillsRef = AutoDisposeFutureProviderRef<List<BillEntity>>;
String _$billDueStatusByIdHash() => r'91c16edb3c5fbc9a1a5ca63ee11b2b9c258ee5b9';

/// See also [billDueStatusById].
@ProviderFor(billDueStatusById)
final billDueStatusByIdProvider =
    AutoDisposeProvider<Map<String, BillDueStatus>>.internal(
  billDueStatusById,
  name: r'billDueStatusByIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$billDueStatusByIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BillDueStatusByIdRef
    = AutoDisposeProviderRef<Map<String, BillDueStatus>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
