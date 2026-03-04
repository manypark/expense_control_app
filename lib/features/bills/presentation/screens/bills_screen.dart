import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/bills/domain/domain.dart';
import 'package:expense_control_app/features/bills/presentation/widgets/widgets.dart';
import 'package:expense_control_app/features/bills/presentation/providers/providers.dart';

class BillsScreen extends ConsumerWidget {
  
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final billsAsync = ref.watch(allBillsProvider);
    final statusById = ref.watch(billDueStatusByIdProvider);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: billsAsync.when(
        data: (bills) => CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              title: const Text('Servicios'),
              actions: [
                IconButton(
                  onPressed: () => _showBillForm(context),
                  icon: const Icon(Icons.add),
                  tooltip: 'Agregar servicio',
                ),
              ],
            ),
            if (bills.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: EmptyBillsText()),
              )
            else
              BillsSliverList(
                bills       : bills,
                statusById  : statusById,
                onTogglePaid: (bill, isPaid) => _togglePaid(ref, bill: bill, isPaid: isPaid),
                onEdit      : (bill) => () => _showBillForm(context, bill: bill),
              ),

              SliverToBoxAdapter(child: SizedBox(height: height * 0.14)),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _showBillForm(BuildContext context, {BillEntity? bill}) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      showCupertinoModalPopup<void>(
        context: context,
        barrierDismissible: true,
        builder: (_) => SafeArea(
          top: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: CupertinoColors.systemBackground.resolveFrom(context),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              clipBehavior: Clip.antiAlias,
              child: BillFormSheet(initialBill: bill),
            ),
          ),
        ),
      );
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BillFormSheet(initialBill: bill),
    );
  }

  Future<void> _togglePaid(
    WidgetRef ref, {
    required BillEntity bill,
    required bool isPaid,
  }) {
    final updated = BillEntity(
      id: bill.id,
      title: bill.title,
      dueDate: bill.dueDate,
      isPaid: isPaid,
    );
    return ref.read(billCommandsProvider.notifier).saveBill(updated);
  }
}
