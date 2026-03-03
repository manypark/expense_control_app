import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/dashboard/domain/entities/entities.dart';

class AccountFormDialog extends ConsumerStatefulWidget {
  const AccountFormDialog({super.key, this.account});

  final MoneyAccountEntity? account;

  @override
  ConsumerState<AccountFormDialog> createState() => _AccountFormDialogState();
}

class _AccountFormDialogState extends ConsumerState<AccountFormDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _codeController;
  late final TextEditingController _balanceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.account?.name ?? '');
    _codeController = TextEditingController(text: widget.account?.code ?? '');
    _balanceController = TextEditingController(
      text: (widget.account?.balance ?? 0).toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSaving = ref.watch(globalLoadingProvider);

    return CupertinoAlertDialog(
      title: Text(widget.account == null ? 'Nueva cuenta' : 'Editar cuenta'),
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            _DialogField(
              controller: _nameController,
              placeholder: 'Nombre visible',
              enabled: !isSaving,
            ),
            _DialogField(
              controller: _codeController,
              placeholder: 'Codigo interno (unico)',
              enabled: !isSaving,
            ),
            _DialogField(
              controller: _balanceController,
              placeholder: 'Monto actual',
              enabled: !isSaving,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: isSaving ? null : _save,
          child: Text(isSaving ? 'Cargando...' : 'Guardar'),
        ),
      ],
    );
  }

  void _save() {
    final entity = MoneyAccountEntity(
      id: widget.account?.id ?? '',
      code: _codeController.text.trim(),
      name: _nameController.text.trim(),
      balance: double.tryParse(_balanceController.text.trim()) ?? 0,
    );

    ref
        .read(accountCommandsProvider.notifier)
        .upsertAccount(entity)
        .then((_) {
          if (!mounted) return;
          Navigator.of(context).pop();
        })
        .catchError((_) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Hubo un error al guardar la cuenta.'),
            ),
          );
        });
  }
}

class _DialogField extends StatelessWidget {
  const _DialogField({
    required this.controller,
    required this.placeholder,
    required this.enabled,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String placeholder;
  final bool enabled;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: CupertinoTextField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        placeholder: placeholder,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
    );
  }
}
