import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_control_app/features/dashboard/domain/entities/entities.dart';

class AccountsPieChartCard extends StatelessWidget {
  const AccountsPieChartCard({super.key, required this.accounts});

  final List<MoneyAccountEntity> accounts;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final total = accounts.fold<double>(
      0,
      (sum, account) => sum + account.balance,
    );
    final currency = NumberFormat.currency(locale: 'es_MX', symbol: r'$');
    final sorted = [...accounts]
      ..sort((a, b) => b.balance.compareTo(a.balance));

    return Container(
      decoration: isIOS
          ? BoxDecoration(
              color: Colors.black12.withAlpha(10),
              borderRadius: BorderRadius.circular(14),
            )
          : null,
      child: Card(
        elevation: isIOS ? 0 : null,
        color: isIOS ? Colors.transparent : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: total <= 0
              ? const SizedBox(
                  height: 180,
                  child: Center(
                    child: Text('Agrega montos para ver la grafica'),
                  ),
                )
              : Column(
                  children: [
                    for (var i = 0; i < sorted.length; i++)
                      _AccountBarRow(
                        account: sorted[i],
                        total: total,
                        amountText: currency.format(sorted[i].balance),
                        color: _palette[i % _palette.length],
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _AccountBarRow extends StatelessWidget {
  const _AccountBarRow({
    required this.account,
    required this.total,
    required this.amountText,
    required this.color,
  });

  final MoneyAccountEntity account;
  final double total;
  final String amountText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ratio = total == 0 ? 0.0 : (account.balance / total).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  account.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                amountText,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 12,
              backgroundColor: color.withValues(alpha: 0.14),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}

const _palette = <Color>[
  Color(0xFF0F766E),
  Color(0xFF2563EB),
  Color(0xFFDC2626),
  Color(0xFFF59E0B),
  Color(0xFF7C3AED),
  Color(0xFF0891B2),
];
