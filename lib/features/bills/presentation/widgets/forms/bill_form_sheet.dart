import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/bills/domain/domain.dart';
import 'bill_form_submit.dart';

class BillFormSheet extends ConsumerStatefulWidget {
  const BillFormSheet({super.key, this.initialBill});

  final BillEntity? initialBill;

  @override
  ConsumerState<BillFormSheet> createState() => _BillFormSheetState();
}

class _BillFormSheetState extends ConsumerState<BillFormSheet> {
  late final TextEditingController _titleCtrl;
  late DateTime _dueDate;
  late bool _isPaid;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.initialBill?.title ?? '');
    _dueDate = widget.initialBill?.dueDate ?? DateTime.now();
    _isPaid = widget.initialBill?.isPaid ?? false;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(globalLoadingProvider);
    final dateText = DateFormat('dd/MM/yyyy').format(_dueDate);

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
            widget.initialBill == null ? 'Nuevo servicio' : 'Editar servicio',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _titleCtrl,
            enabled: !isLoading,
            decoration: const InputDecoration(labelText: 'Titulo'),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: Text('Fecha: $dateText')),
              TextButton(
                onPressed: isLoading ? null : _pickDate,
                child: const Text('Cambiar'),
              ),
            ],
          ),
          CheckboxListTile(
            value: _isPaid,
            onChanged: isLoading
                ? null
                : (value) {
                    if (value == null) return;
                    setState(() => _isPaid = value);
                  },
            contentPadding: EdgeInsets.zero,
            title: const Text('Ya pagado'),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: isLoading ? null : _submit,
              child: Text(isLoading ? 'Cargando...' : 'Guardar'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: _dueDate,
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  Future<void> _submit() async {
    final bill = BillEntity(
      id: widget.initialBill?.id ?? '',
      title: _titleCtrl.text.trim(),
      dueDate: _dueDate,
      isPaid: _isPaid,
    );
    await submitBillForm(context: context, ref: ref, bill: bill);
  }
}
