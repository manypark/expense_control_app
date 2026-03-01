import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/bills/domain/domain.dart';
import 'package:expense_control_app/features/bills/presentation/providers/providers.dart';

class BillsScreen extends ConsumerWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billsAsync = ref.watch(allBillsProvider);
    final statusById = ref.watch(billDueStatusByIdProvider);
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      body: billsAsync.when(
        data: (bills) {
          return CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              const SliverAppBar(pinned: true, title: Text('Servicios')),
              if (bills.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text('Aun no has registrado servicios por pagar'),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList.list(
                    children: [
                      for (final bill in bills)
                        Card(
                          child: ListTile(
                            title: Text(bill.title),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Chip(
                                  label: Text(dateFormat.format(bill.dueDate)),
                                  visualDensity: VisualDensity.compact,
                                  backgroundColor: _chipColor(
                                    statusById[bill.id] ?? BillDueStatus.green,
                                  ),
                                  labelStyle: TextStyle(
                                    color: _chipTextColor(
                                      statusById[bill.id] ??
                                          BillDueStatus.green,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            leading: Checkbox(
                              value: bill.isPaid,
                              onChanged: (value) async {
                                if (value == null) return;
                                await _saveBill(
                                  context,
                                  ref,
                                  bill.copyWith(isPaid: value),
                                );
                              },
                            ),
                            trailing: IconButton(
                              onPressed: () =>
                                  _showBillForm(context, ref, bill: bill),
                              icon: const Icon(Icons.edit_outlined),
                              tooltip: 'Editar',
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showBillForm(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Agregar servicio'),
      ),
    );
  }

  Future<void> _showBillForm(
    BuildContext context,
    WidgetRef ref, {
    BillEntity? bill,
  }) async {
    final titleController = TextEditingController(text: bill?.title ?? '');
    var dueDate = bill?.dueDate ?? DateTime.now();
    var isPaid = bill?.isPaid ?? false;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Consumer(
          builder: (context, modalRef, _) {
            final isLoading = modalRef.watch(globalLoadingProvider);

            return StatefulBuilder(
              builder: (context, setModalState) {
                final dateText = DateFormat('dd/MM/yyyy').format(dueDate);

                return Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        bill == null ? 'Nuevo servicio' : 'Editar servicio',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: titleController,
                        enabled: !isLoading,
                        decoration: const InputDecoration(labelText: 'Titulo'),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: Text('Fecha de pago: $dateText')),
                          TextButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2100),
                                      initialDate: dueDate,
                                    );
                                    if (picked != null) {
                                      setModalState(() => dueDate = picked);
                                    }
                                  },
                            child: const Text('Cambiar'),
                          ),
                        ],
                      ),
                      CheckboxListTile(
                        value: isPaid,
                        onChanged: isLoading
                            ? null
                            : (value) {
                                if (value == null) return;
                                setModalState(() => isPaid = value);
                              },
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Ya pagado'),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  final entity = BillEntity(
                                    id: bill?.id ?? '',
                                    title: titleController.text.trim(),
                                    dueDate: dueDate,
                                    isPaid: isPaid,
                                  );

                                  final success = await _saveBill(
                                    context,
                                    ref,
                                    entity,
                                  );
                                  if (success && context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                },
                          child: Text(isLoading ? 'Cargando...' : 'Guardar'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<bool> _saveBill(
    BuildContext context,
    WidgetRef ref,
    BillEntity bill,
  ) async {
    try {
      await ref.read(billCommandsProvider.notifier).saveBill(bill);
      return true;
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hubo un error al guardar el servicio.'),
          ),
        );
      }
      return false;
    }
  }
}

Color _chipColor(BillDueStatus status) {
  switch (status) {
    case BillDueStatus.green:
      return Colors.green.shade600;
    case BillDueStatus.yellow:
      return Colors.amber.shade700;
    case BillDueStatus.red:
      return Colors.red.shade600;
  }
}

Color _chipTextColor(BillDueStatus status) {
  switch (status) {
    case BillDueStatus.green:
    case BillDueStatus.red:
      return Colors.white;
    case BillDueStatus.yellow:
      return Colors.black;
  }
}

extension on BillEntity {
  BillEntity copyWith({
    String? id,
    String? title,
    DateTime? dueDate,
    bool? isPaid,
  }) {
    return BillEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      isPaid: isPaid ?? this.isPaid,
    );
  }
}
