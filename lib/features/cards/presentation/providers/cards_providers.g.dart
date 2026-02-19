// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cards_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$availableCardsHash() => r'7121e17c6893aa00d0a9348deb9846405b87854f';

/// See also [availableCards].
@ProviderFor(availableCards)
final availableCardsProvider =
    AutoDisposeProvider<AsyncValue<List<CreditCardEntity>>>.internal(
      availableCards,
      name: r'availableCardsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$availableCardsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef AvailableCardsRef =
    AutoDisposeProviderRef<AsyncValue<List<CreditCardEntity>>>;
String _$cardsByIdHash() => r'261662b0f9c480681163c3a45cfefef073f36c6c';

/// See also [cardsById].
@ProviderFor(cardsById)
final cardsByIdProvider =
    AutoDisposeProvider<Map<int, CreditCardEntity>>.internal(
      cardsById,
      name: r'cardsByIdProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cardsByIdHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef CardsByIdRef = AutoDisposeProviderRef<Map<int, CreditCardEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
