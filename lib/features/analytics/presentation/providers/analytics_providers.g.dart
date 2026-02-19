// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$spendingByCategoryHash() =>
    r'e3a0ba26a496c699e44c9407af646c8c4bb323a6';

/// See also [spendingByCategory].
@ProviderFor(spendingByCategory)
final spendingByCategoryProvider =
    AutoDisposeProvider<List<(String label, double value)>>.internal(
      spendingByCategory,
      name: r'spendingByCategoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$spendingByCategoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef SpendingByCategoryRef =
    AutoDisposeProviderRef<List<(String label, double value)>>;
String _$spendingByCardHash() => r'295b02fbbeecf59645b628c36deffd83b5d0b35e';

/// See also [spendingByCard].
@ProviderFor(spendingByCard)
final spendingByCardProvider =
    AutoDisposeProvider<List<(String label, double value)>>.internal(
      spendingByCard,
      name: r'spendingByCardProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$spendingByCardHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef SpendingByCardRef =
    AutoDisposeProviderRef<List<(String label, double value)>>;
String _$spendingByMonthHash() => r'55774c212984cc6a58607135e1d5c9341583da04';

/// See also [spendingByMonth].
@ProviderFor(spendingByMonth)
final spendingByMonthProvider =
    AutoDisposeProvider<List<(String month, double value)>>.internal(
      spendingByMonth,
      name: r'spendingByMonthProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$spendingByMonthHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef SpendingByMonthRef =
    AutoDisposeProviderRef<List<(String month, double value)>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
