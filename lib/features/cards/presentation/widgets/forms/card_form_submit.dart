import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_control_app/features/cards/domain/entities/entities.dart';
import 'package:expense_control_app/features/cards/presentation/providers/providers.dart';

void submitCardForm({
  required BuildContext context,
  required WidgetRef ref,
  required CreditCardEntity? card,
  required TextEditingController alias,
  required TextEditingController bank,
  required TextEditingController last4,
  required TextEditingController closing,
  required TextEditingController due,
  required TextEditingController limit,
}) {
  ref
      .read(cardFormActionsProvider.notifier)
      .submit(
        context: context,
        payload: CardFormPayload(
          id: card?.id ?? '',
          alias: alias.text.trim(),
          bank: bank.text.trim(),
          last4: last4.text.trim(),
          closingDay: int.tryParse(closing.text.trim()) ?? 25,
          dueDay: int.tryParse(due.text.trim()) ?? 10,
          creditLimit: double.tryParse(limit.text.trim()) ?? 0,
        ),
      );
}
