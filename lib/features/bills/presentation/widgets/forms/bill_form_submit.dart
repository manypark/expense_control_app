import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/bills/domain/domain.dart';

Future<void> submitBillForm({
  required BuildContext context,
  required WidgetRef ref,
  required BillEntity bill,
}) async {
  try {
    await ref.read(billCommandsProvider.notifier).saveBill(bill);
    if (context.mounted) Navigator.of(context).pop();
  } catch (_) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Hubo un error al guardar el servicio.')),
    );
  }
}
