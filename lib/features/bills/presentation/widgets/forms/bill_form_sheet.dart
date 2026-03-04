import 'package:flutter/cupertino.dart';
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
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

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
          if (isIOS)
            CupertinoTextField(
              controller: _titleCtrl,
              enabled: !isLoading,
              placeholder: 'Titulo',
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            )
          else
            TextField(
              controller: _titleCtrl,
              enabled: !isLoading,
              decoration: const InputDecoration(labelText: 'Titulo'),
            ),
          const SizedBox(height: 8),
          _DateRow(
            isIOS: isIOS,
            dueDate: _dueDate,
            isLoading: isLoading,
            onChanged: (value) => setState(() => _dueDate = value),
          ),
          const SizedBox(height: 8),
          _PaidField(
            isIOS: isIOS,
            isPaid: _isPaid,
            isLoading: isLoading,
            onChanged: (value) => setState(() => _isPaid = value),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: isIOS
                ? CupertinoButton.filled(
                    onPressed: isLoading ? null : _submit,
                    child: Text(isLoading ? 'Cargando...' : 'Guardar'),
                  )
                : FilledButton(
                    onPressed: isLoading ? null : _submit,
                    child: Text(isLoading ? 'Cargando...' : 'Guardar'),
                  ),
          ),
        ],
      ),
    );
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

class _DateRow extends StatelessWidget {
  const _DateRow({
    required this.isIOS,
    required this.dueDate,
    required this.isLoading,
    required this.onChanged,
  });

  final bool isIOS;
  final DateTime dueDate;
  final bool isLoading;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final text = DateFormat('dd/MM/yyyy').format(dueDate);

    if (!isIOS) {
      return Row(
        children: [
          Expanded(child: Text('Fecha: $text')),
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
                    if (picked != null) onChanged(picked);
                  },
            child: const Text('Cambiar'),
          ),
        ],
      );
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: isLoading
          ? null
          : () async {
              DateTime tempDate = dueDate;
              final picked = await showCupertinoModalPopup<DateTime>(
                context: context,
                builder: (_) => _CupertinoDatePickerSheet(
                  initialDate: dueDate,
                  onChanged: (value) => tempDate = value,
                ),
              );
              onChanged(picked ?? tempDate);
            },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6.resolveFrom(context),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: CupertinoColors.label.resolveFrom(context),
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 18),
          ],
        ),
      ),
    );
  }
}

class _PaidField extends StatelessWidget {
  const _PaidField({
    required this.isIOS,
    required this.isPaid,
    required this.isLoading,
    required this.onChanged,
  });

  final bool isIOS;
  final bool isPaid;
  final bool isLoading;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    if (!isIOS) {
      return CheckboxListTile(
        value: isPaid,
        onChanged: isLoading
            ? null
            : (value) {
                if (value == null) return;
                onChanged(value);
              },
        contentPadding: EdgeInsets.zero,
        title: const Text('Ya pagado'),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6.resolveFrom(context),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            'Ya pagado',
            style: TextStyle(color: CupertinoColors.label.resolveFrom(context)),
          ),
          const Spacer(),
          CupertinoSwitch(
            value: isPaid,
            onChanged: isLoading ? null : onChanged,
          ),
        ],
      ),
    );
  }
}

class _CupertinoDatePickerSheet extends StatelessWidget {
  const _CupertinoDatePickerSheet({
    required this.initialDate,
    required this.onChanged,
  });

  final DateTime initialDate;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = initialDate;

    return Container(
      height: 280,
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CupertinoButton(
              onPressed: () => Navigator.of(context).pop(currentDate),
              child: const Text('Listo'),
            ),
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialDate,
              onDateTimeChanged: (value) {
                currentDate = value;
                onChanged(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
