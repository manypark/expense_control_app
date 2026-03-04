import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/cards/domain/entities/entities.dart';

part 'card_form_providers.g.dart';

class CardFormPayload {
  const CardFormPayload({
    required this.id,
    required this.alias,
    required this.bank,
    required this.last4,
    required this.closingDay,
    required this.dueDay,
    required this.creditLimit,
  });

  final String id;
  final String alias;
  final String bank;
  final String last4;
  final int closingDay;
  final int dueDay;
  final double creditLimit;

  CreditCardEntity toEntity() {
    return CreditCardEntity(
      id: id,
      alias: alias,
      bank: bank,
      last4: last4,
      closingDay: closingDay,
      dueDay: dueDay,
      creditLimit: creditLimit,
    );
  }
}

@riverpod
class CardFormActions extends _$CardFormActions {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> submit({
    required BuildContext context,
    required CardFormPayload payload,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(cardCommandsProvider.notifier)
          .saveCard(payload.toEntity());
      if (context.mounted) Navigator.of(context).pop();
    });

    if (state.hasError && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hubo un error al guardar la tarjeta.')),
      );
    }
  }
}
