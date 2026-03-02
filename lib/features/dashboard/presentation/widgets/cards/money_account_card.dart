import 'package:expense_control_app/features/dashboard/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class MoneyAccountCard extends StatelessWidget {
  const MoneyAccountCard({
    super.key,
    required this.account,
    required this.balanceText,
    required this.onEdit,
    required this.onDelete,
  });

  final MoneyAccountEntity account;
  final String balanceText;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(account.name),
        subtitle: Text(account.code),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(balanceText),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Eliminar',
            ),
          ],
        ),
        onTap: onEdit,
      ),
    );
  }
}
