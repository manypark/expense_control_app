import 'package:expense_control_app/features/dashboard/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'money_account_card.dart';

class MoneyAccountsSliverList extends StatelessWidget {
  const MoneyAccountsSliverList({
    super.key,
    required this.accounts,
    required this.currency,
    required this.onEdit,
    required this.onDelete,
  });

  final List<MoneyAccountEntity> accounts;
  final NumberFormat currency;
  final void Function(MoneyAccountEntity account) onEdit;
  final void Function(MoneyAccountEntity account) onDelete;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final account = accounts[index];
        return MoneyAccountCard(
          account: account,
          balanceText: currency.format(account.balance),
          onEdit: () => onEdit(account),
          onDelete: () => onDelete(account),
        );
      }, childCount: accounts.length),
    );
  }
}
