import 'package:flutter/cupertino.dart';
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
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final title = widget.account == null ? 'Nueva cuenta' : 'Editar cuenta';

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
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
                tooltip: 'Cerrar',
              ),
            ],
          ),
          const SizedBox(height: 12),
          _AdaptiveField(
            controller: _nameController,
            enabled: !isSaving,
            label: 'Nombre visible',
            isIOS: isIOS,
          ),
          _AdaptiveField(
            controller: _codeController,
            enabled: !isSaving,
            label: 'Codigo interno (unico)',
            isIOS: isIOS,
          ),
          _AdaptiveField(
            controller: _balanceController,
            enabled: !isSaving,
            label: 'Monto actual',
            isIOS: isIOS,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: isIOS
                ? CupertinoButton.filled(
                    onPressed: isSaving ? null : _save,
                    child: Text(isSaving ? 'Cargando...' : 'Guardar'),
                  )
                : FilledButton(
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

class _AdaptiveField extends StatelessWidget {
  const _AdaptiveField({
    required this.controller,
    required this.enabled,
    required this.label,
    required this.isIOS,
    this.keyboardType,
  });

  final TextEditingController controller;
  final bool enabled;
  final String label;
  final bool isIOS;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: CupertinoTextField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          placeholder: label,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      );
    }
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
    );
  }
}
