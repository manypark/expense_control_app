import 'dart:io';

import 'package:expense_control_app/core/constants/app_constants.dart';
import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_control_app/features/expenses/domain/usecases/save_expense_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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
  int? _selectedCardId;
  String? _receiptPath;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titulo'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripcion'),
            ),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Categoria'),
              items: AppConstants.expenseCategories
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ),
                  )
                  .toList(growable: false),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedCategory = value);
                }
              },
            ),
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Monto'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Fecha: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                      initialDate: _selectedDate,
                    );
                    if (picked != null) {
                      setState(() => _selectedDate = picked);
                    }
                  },
                  child: const Text('Cambiar'),
                ),
              ],
            ),
            DropdownButtonFormField<int?>(
              initialValue: _selectedCardId,
              decoration: const InputDecoration(
                labelText: 'Tarjeta de credito (opcional)',
              ),
              items: [
                const DropdownMenuItem<int?>(
                  value: null,
                  child: Text('Sin tarjeta / contado'),
                ),
                ...widget.cards.map(
                  (card) => DropdownMenuItem<int?>(
                    value: card.id,
                    child: Text(card.label),
                  ),
                ),
              ],
              onChanged: (value) => setState(() => _selectedCardId = value),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _receiptPath == null
                        ? 'Sin ticket adjunto'
                        : 'Ticket listo para guardar',
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: _pickReceiptImage,
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text('Foto'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saveExpense,
                child: const Text('Guardar gasto'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickReceiptImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    final docs = await getApplicationDocumentsDirectory();
    final receiptsDir = Directory('${docs.path}/receipts');
    if (!receiptsDir.existsSync()) {
      receiptsDir.createSync(recursive: true);
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final targetPath = '${receiptsDir.path}/receipt_$timestamp.jpg';
    await File(image.path).copy(targetPath);

    setState(() => _receiptPath = targetPath);
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
      id: 0,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
      amount: amount,
      incurredAt: _selectedDate,
      creditCardId: _selectedCardId,
      receiptPath: _receiptPath,
      statementYear: cycle.statementYear,
      statementMonth: cycle.statementMonth,
    );

    await ref.read(expenseCommandsProvider.notifier).saveExpense(expense);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
