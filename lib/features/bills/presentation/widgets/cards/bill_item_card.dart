import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_control_app/features/bills/domain/domain.dart';
import 'package:expense_control_app/features/bills/presentation/providers/providers.dart';

import 'bill_due_chip.dart';

class BillItemCard extends StatelessWidget {
  const BillItemCard({
    super.key,
    required this.bill,
    required this.status,
    required this.onTogglePaid,
    required this.onEdit,
  });

  final BillEntity bill;
  final BillDueStatus status;
  final ValueChanged<bool> onTogglePaid;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final dateText = DateFormat('dd/MM/yyyy').format(bill.dueDate);

    return Card(
      child: ListTile(
        title: Text(bill.title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Align(
            alignment: Alignment.centerLeft,
            child: BillDueChip(label: dateText, status: status),
          ),
        ),
        leading: Checkbox(
          value: bill.isPaid,
          onChanged: (value) {
            if (value == null) return;
            onTogglePaid(value);
          },
        ),
        trailing: IconButton(
          onPressed: onEdit,
          icon: const Icon(Icons.edit_outlined),
          tooltip: 'Editar',
        ),
      ),
    );
  }
}
