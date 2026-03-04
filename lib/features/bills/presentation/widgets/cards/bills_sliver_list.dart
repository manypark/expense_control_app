import 'package:flutter/material.dart';

import 'package:expense_control_app/features/bills/domain/domain.dart';
import 'package:expense_control_app/features/bills/presentation/providers/providers.dart';

import 'bill_item_card.dart';
import 'bill_item_tile_ios.dart';

class BillsSliverList extends StatelessWidget {
  const BillsSliverList({
    super.key,
    required this.bills,
    required this.statusById,
    required this.onTogglePaid,
    required this.onEdit,
  });

  final List<BillEntity> bills;
  final Map<String, BillDueStatus> statusById;
  final Future<void> Function(BillEntity bill, bool isPaid) onTogglePaid;
  final VoidCallback Function(BillEntity bill) onEdit;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final bill = bills[index];
          if (isIOS) {
            return BillItemTileIos(
              bill: bill,
              status: statusById[bill.id] ?? BillDueStatus.green,
              onTogglePaid: (isPaid) => onTogglePaid(bill, isPaid),
              onEdit: onEdit(bill),
            );
          }
          return BillItemCard(
            bill: bill,
            status: statusById[bill.id] ?? BillDueStatus.green,
            onTogglePaid: (isPaid) => onTogglePaid(bill, isPaid),
            onEdit: onEdit(bill),
          );
        }, childCount: bills.length),
      ),
    );
  }
}
