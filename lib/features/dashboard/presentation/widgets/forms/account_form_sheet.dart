import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/dashboard/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountFormSheet extends ConsumerStatefulWidget {
  const AccountFormSheet({super.key, this.account});

  final MoneyAccountEntity? account;

  @override
  ConsumerState<AccountFormSheet> createState() => _AccountFormSheetState();
}

class _AccountFormSheetState extends ConsumerState<AccountFormSheet> {
  late final TextEditingController _codeController;
  late final TextEditingController _nameController;
  late final TextEditingController _balanceController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.account?.code ?? '');
    _nameController = TextEditingController(text: widget.account?.name ?? '');
    _balanceController = TextEditingController(
      text: (widget.account?.balance ?? 0).toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSaving = ref.watch(globalLoadingProvider);

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
            widget.account == null ? 'Nueva cuenta' : 'Editar cuenta',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            enabled: !isSaving,
            decoration: const InputDecoration(labelText: 'Nombre visible'),
          ),
          TextField(
            controller: _codeController,
            enabled: !isSaving,
            decoration: const InputDecoration(
              labelText: 'Codigo interno (unico)',
            ),
          ),
          TextField(
            controller: _balanceController,
            enabled: !isSaving,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Monto actual'),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: isSaving ? null : _save,
              child: Text(isSaving ? 'Cargando...' : 'Guardar'),
            ),
          ),
        ],
      ),
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
