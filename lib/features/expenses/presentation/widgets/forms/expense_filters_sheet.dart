import 'package:flutter/material.dart';

import 'package:expense_control_app/core/constants/app_constants.dart';

class ExpenseFiltersSheet extends StatelessWidget {
  const ExpenseFiltersSheet({
    super.key,
    required this.selectedCategory,
    required this.dateLabel,
    required this.hasFilters,
    required this.onCategoryChanged,
    required this.onPickRange,
    required this.onClear,
  });

  final String? selectedCategory;
  final String dateLabel;
  final bool hasFilters;
  final ValueChanged<String?> onCategoryChanged;
  final VoidCallback onPickRange;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          20,
          16,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filtros',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String?>(
              key: ValueKey(selectedCategory),
              initialValue: selectedCategory,
              decoration: const InputDecoration(labelText: 'Categoria'),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('Todas'),
                ),
                ...AppConstants.expenseCategories.map(
                  (item) =>
                      DropdownMenuItem<String?>(value: item, child: Text(item)),
                ),
              ],
              onChanged: onCategoryChanged,
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Rango de fechas'),
              subtitle: Text(dateLabel),
              trailing: const Icon(Icons.calendar_month_outlined),
              onTap: onPickRange,
            ),
            if (hasFilters)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onClear,
                  child: const Text('Limpiar filtros'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
