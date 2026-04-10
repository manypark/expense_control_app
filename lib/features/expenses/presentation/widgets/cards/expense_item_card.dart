import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';

class ExpenseItemCard extends StatelessWidget {
  const ExpenseItemCard({
    super.key,
    required this.expense,
    required this.cardsById,
    required this.amountText,
    required this.onEdit,
    required this.onDelete,
  });

  final String amountText;
  final ExpenseEntity expense;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Map<String, CreditCardEntity> cardsById;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateText = DateFormat(
      'dd MMM yyyy',
      'es_MX',
    ).format(expense.incurredAt);
    final sourceLabel = expense.creditCardId == null
        ? 'Efectivo/Contado'
        : (cardsById[expense.creditCardId!]?.label ?? 'Tarjeta');

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              _ExpenseIconBadge(category: expense.category),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateText.toUpperCase(),
                      style: TextStyle(
                        color: theme.colorScheme.outline,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      expense.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        height: 0.95,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          expense.creditCardId == null
                              ? Icons.payments_outlined
                              : Icons.credit_card,
                          size: 15,
                          color: theme.colorScheme.outline,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            sourceLabel,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: theme.colorScheme.outline,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    amountText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: onDelete,
                    borderRadius: BorderRadius.circular(999),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpenseIconBadge extends StatelessWidget {
  const _ExpenseIconBadge({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(_iconFor(category), color: colorScheme.primary, size: 30),
    );
  }

  IconData _iconFor(String category) {
    switch (category.toLowerCase()) {
      case 'comida':
      case 'restaurantes':
        return Icons.restaurant_outlined;
      case 'supermercado':
      case 'despensa':
        return Icons.shopping_cart_outlined;
      case 'cafeteria':
      case 'cafe':
        return Icons.local_cafe_outlined;
      case 'entretenimiento':
        return Icons.sports_esports_outlined;
      case 'transporte':
        return Icons.directions_car_outlined;
      case 'salud':
        return Icons.medical_services_outlined;
      default:
        return Icons.wallet_outlined;
    }
  }
}
