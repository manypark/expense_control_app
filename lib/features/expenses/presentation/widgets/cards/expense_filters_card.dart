import 'package:flutter/material.dart';

import 'package:expense_control_app/core/constants/app_constants.dart';

class ExpenseFiltersCard extends StatelessWidget {
  const ExpenseFiltersCard({
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
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
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: Text(dateLabel)),
                TextButton(onPressed: onPickRange, child: const Text('Rango')),
                if (hasFilters)
                  TextButton(onPressed: onClear, child: const Text('Limpiar')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
