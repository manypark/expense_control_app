import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_control_app/features/bills/domain/domain.dart';
import 'package:expense_control_app/features/bills/presentation/providers/providers.dart';

import 'bill_due_chip.dart';

class BillItemTileIos extends StatelessWidget {
  const BillItemTileIos({
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

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
      decoration: BoxDecoration(
        color       : Colors.black12.withAlpha(10),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CupertinoSwitch(value: bill.isPaid, onChanged: onTogglePaid),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bill.title,
                  style: TextStyle(
                    color: CupertinoColors.label.resolveFrom(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                BillDueChip(label: dateText, status: status),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Editar',
          ),
        ],
      ),
    );
  }
}
