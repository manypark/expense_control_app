import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/dashboard/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showDeleteAccountDialog(
  BuildContext context,
  WidgetRef ref,
  MoneyAccountEntity account,
) {
  showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Eliminar cuenta'),
        content: Text(
          'Se eliminara ${account.name}. Esta accion no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      );
    },
  ).then((accepted) {
    if (accepted == true) {
      ref.read(accountCommandsProvider.notifier).deleteAccount(account.id);
    }
  });
}
