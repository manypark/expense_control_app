import 'package:flutter/cupertino.dart';
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
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) return _CupertinoAccountCard(this);
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

class _CupertinoAccountCard extends StatelessWidget {
  const _CupertinoAccountCard(this.card);

  final MoneyAccountCard card;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: card.onEdit,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
        decoration: BoxDecoration(
          color: Colors.black12.withAlpha(10),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.account.name,
                    style: TextStyle(
                      color: CupertinoColors.label.resolveFrom(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    card.account.code,
                    style: TextStyle(
                      color: CupertinoColors.secondaryLabel.resolveFrom(
                        context,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              card.balanceText,
              style: TextStyle(
                color: CupertinoColors.label.resolveFrom(context),
              ),
            ),
            CupertinoButton(
              padding: const EdgeInsets.only(left: 8),
              minimumSize: const Size.square(28),
              onPressed: card.onDelete,
              child: const Icon(Icons.delete_outline, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
