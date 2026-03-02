import 'package:flutter/material.dart';

import 'package:expense_control_app/features/bills/presentation/providers/providers.dart';

class BillDueChip extends StatelessWidget {
  const BillDueChip({super.key, required this.label, required this.status});

  final String label;
  final BillDueStatus status;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      visualDensity: VisualDensity.compact,
      backgroundColor: _chipColor(status),
      labelStyle: TextStyle(
        color: _chipTextColor(status),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Color _chipColor(BillDueStatus value) {
    switch (value) {
      case BillDueStatus.green:
        return Colors.green.shade600;
      case BillDueStatus.yellow:
        return Colors.amber.shade700;
      case BillDueStatus.red:
        return Colors.red.shade600;
    }
  }

  Color _chipTextColor(BillDueStatus value) {
    switch (value) {
      case BillDueStatus.yellow:
        return Colors.black;
      case BillDueStatus.green:
      case BillDueStatus.red:
        return Colors.white;
    }
  }
}
