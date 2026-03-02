import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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

    return SizedBox(
      height: 220,
      child: Container(
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
                ? const Center(child: Text('Agrega montos para ver la grafica'))
                : PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 32,
                      sections: [
                        for (var i = 0; i < accounts.length; i++)
                          PieChartSectionData(
                            value: accounts[i].balance,
                            title: accounts[i].name,
                            radius: 42,
                            color:
                                Colors.primaries[i % Colors.primaries.length],
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
