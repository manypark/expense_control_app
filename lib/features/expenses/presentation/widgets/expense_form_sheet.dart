import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_control_app/core/constants/app_constants.dart';
import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_control_app/features/expenses/domain/usecases/save_expense_usecase.dart';

class ExpenseFormSheet extends ConsumerStatefulWidget {
  const ExpenseFormSheet({super.key, required this.cards});

  final List<CreditCardEntity> cards;

  @override
  ConsumerState<ExpenseFormSheet> createState() => _ExpenseFormSheetState();
}

class _ExpenseFormSheetState extends ConsumerState<ExpenseFormSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = AppConstants.expenseCategories.first;
  String? _selectedCardId;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSaving = ref.watch(globalLoadingProvider);
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Registrar gasto',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            _AdaptiveTextField(
              controller: _titleController,
              label: 'Titulo',
              isIOS: isIOS,
            ),
            _AdaptiveTextField(
              controller: _descriptionController,
              label: 'Descripcion',
              isIOS: isIOS,
            ),
            _AdaptiveCategoryField(
              isIOS: isIOS,
              selectedCategory: _selectedCategory,
              onChanged: (value) => setState(() => _selectedCategory = value),
            ),
            _AdaptiveTextField(
              controller: _amountController,
              label: 'Monto',
              isIOS: isIOS,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 8),
            _AdaptiveDateField(
              isIOS: isIOS,
              selectedDate: _selectedDate,
              enabled: !isSaving,
              onChanged: (value) => setState(() => _selectedDate = value),
            ),
            _AdaptiveCardField(
              isIOS: isIOS,
              selectedCardId: _selectedCardId,
              cards: widget.cards,
              enabled: !isSaving,
              onChanged: (value) => setState(() => _selectedCardId = value),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: isIOS
                  ? CupertinoButton.filled(
                      onPressed: isSaving ? null : _saveExpense,
                      child: Text(isSaving ? 'Cargando...' : 'Guardar gasto'),
                    )
                  : FilledButton(
                      onPressed: isSaving ? null : _saveExpense,
                      child: Text(isSaving ? 'Cargando...' : 'Guardar gasto'),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveExpense() async {
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    final selectedCard = widget.cards
        .where((card) => card.id == _selectedCardId)
        .firstOrNull;

    final cycle = selectedCard == null
        ? (
            statementYear: _selectedDate.year,
            statementMonth: _selectedDate.month,
          )
        : SaveExpenseUseCase.calculateStatementCycle(
            expenseDate: _selectedDate,
            card: selectedCard,
          );

    final expense = ExpenseEntity(
      id: '',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
      amount: amount,
      incurredAt: _selectedDate,
      creditCardId: _selectedCardId,
      statementYear: cycle.statementYear,
      statementMonth: cycle.statementMonth,
    );

    try {
      await ref.read(expenseCommandsProvider.notifier).saveExpense(expense);
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hubo un error al guardar el gasto.')),
      );
    }
  }
}

class _AdaptiveTextField extends StatelessWidget {
  const _AdaptiveTextField({
    required this.controller,
    required this.label,
    required this.isIOS,
    this.keyboardType,
  });

  final TextEditingController controller;
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
          keyboardType: keyboardType,
          placeholder: label,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      );
    }
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
    );
  }
}

class _AdaptiveCategoryField extends StatelessWidget {
  const _AdaptiveCategoryField({
    required this.isIOS,
    required this.selectedCategory,
    required this.onChanged,
  });

  final bool isIOS;
  final String selectedCategory;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    if (!isIOS) {
      return DropdownButtonFormField<String>(
        initialValue: selectedCategory,
        decoration: const InputDecoration(labelText: 'Categoria'),
        items: AppConstants.expenseCategories
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(growable: false),
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      );
    }

    return _CupertinoPickerField<String>(
      label: 'Categoria',
      text: selectedCategory,
      leadingIcon: Icons.category_outlined,
      onTap: () async {
        final value = await _showChoiceSheet<String>(
          context,
          title: 'Categoria',
          options: AppConstants.expenseCategories,
          selectedValue: selectedCategory,
          toLabel: (item) => item,
        );
        if (value != null) onChanged(value);
      },
    );
  }
}

class _AdaptiveDateField extends StatelessWidget {
  const _AdaptiveDateField({
    required this.isIOS,
    required this.selectedDate,
    required this.enabled,
    required this.onChanged,
  });

  final bool isIOS;
  final DateTime selectedDate;
  final bool enabled;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final text =
        'Fecha: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';

    if (!isIOS) {
      return Row(
        children: [
          Expanded(child: Text(text)),
          TextButton(
            onPressed: !enabled
                ? null
                : () async {
                    final picked = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                      initialDate: selectedDate,
                    );
                    if (picked != null) onChanged(picked);
                  },
            child: const Text('Cambiar'),
          ),
        ],
      );
    }

    return _CupertinoPickerField<DateTime>(
      label: 'Fecha',
      text: text.replaceFirst('Fecha: ', ''),
      leadingIcon: Icons.calendar_today_outlined,
      enabled: enabled,
      onTap: () async {
        DateTime tempDate = selectedDate;
        final picked = await showCupertinoModalPopup<DateTime>(
          context: context,
          builder: (_) => _CupertinoDatePickerSheet(
            initialDate: selectedDate,
            onChanged: (value) => tempDate = value,
          ),
        );
        onChanged(picked ?? tempDate);
      },
    );
  }
}

class _AdaptiveCardField extends StatelessWidget {
  const _AdaptiveCardField({
    required this.isIOS,
    required this.selectedCardId,
    required this.cards,
    required this.enabled,
    required this.onChanged,
  });

  final bool isIOS;
  final String? selectedCardId;
  final List<CreditCardEntity> cards;
  final bool enabled;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    if (!isIOS) {
      return DropdownButtonFormField<String?>(
        initialValue: selectedCardId,
        decoration: const InputDecoration(
          labelText: 'Tarjeta de credito (opcional)',
        ),
        items: [
          const DropdownMenuItem<String?>(
            value: null,
            child: Text('Sin tarjeta / contado'),
          ),
          ...cards.map(
            (card) => DropdownMenuItem<String?>(
              value: card.id,
              child: Text(card.label),
            ),
          ),
        ],
        onChanged: enabled ? onChanged : null,
      );
    }

    final selectedLabel = selectedCardId == null
        ? 'Sin tarjeta / contado'
        : (cards
                  .where((card) => card.id == selectedCardId)
                  .firstOrNull
                  ?.label ??
              'Tarjeta');

    return _CupertinoPickerField<String?>(
      label: 'Tarjeta',
      text: selectedLabel,
      leadingIcon: Icons.credit_card_outlined,
      enabled: enabled,
      onTap: () async {
        final options = [null, ...cards.map((card) => card.id)];
        final value = await _showChoiceSheet<String?>(
          context,
          title: 'Tarjeta de credito',
          options: options,
          selectedValue: selectedCardId,
          toLabel: (id) {
            if (id == null) return 'Sin tarjeta / contado';
            return cards.where((card) => card.id == id).firstOrNull?.label ??
                'Tarjeta';
          },
        );
        if (value != null || selectedCardId != null) onChanged(value);
      },
    );
  }
}

class _CupertinoPickerField<T> extends StatelessWidget {
  const _CupertinoPickerField({
    required this.label,
    required this.text,
    required this.leadingIcon,
    required this.onTap,
    this.enabled = true,
  });

  final String label;
  final String text;
  final IconData leadingIcon;
  final bool enabled;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: enabled ? onTap : null,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey6.resolveFrom(context),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  leadingIcon,
                  size: 18,
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 11,
                        color: CupertinoColors.secondaryLabel.resolveFrom(
                          context,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      text,
                      style: TextStyle(
                        color: CupertinoColors.label.resolveFrom(context),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, size: 18),
            ],
          ),
        ),
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

Future<T?> _showChoiceSheet<T>(
  BuildContext context, {
  required String title,
  required List<T> options,
  required T? selectedValue,
  required String Function(T) toLabel,
}) {
  return showCupertinoModalPopup<T>(
    context: context,
    builder: (_) => CupertinoActionSheet(
      title: Text(title),
      actions: [
        for (final option in options)
          CupertinoActionSheetAction(
            isDefaultAction: option == selectedValue,
            onPressed: () => Navigator.of(context).pop(option),
            child: Text(toLabel(option)),
          ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancelar'),
      ),
    ),
  );
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
