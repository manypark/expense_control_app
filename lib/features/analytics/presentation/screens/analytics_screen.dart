import 'package:expense_control_app/features/analytics/presentation/providers/analytics_providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final byMonth = ref.watch(spendingByMonthProvider);
    final byCategory = ref.watch(spendingByCategoryProvider);
    final byCard = ref.watch(spendingByCardProvider);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Gastos por mes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          SizedBox(height: 220, child: _MonthBarChart(data: byMonth)),
          const SizedBox(height: 16),
          const Text(
            'Gastos por categoria',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          SizedBox(height: 220, child: _PieFromTuples(data: byCategory)),
          const SizedBox(height: 16),
          const Text(
            'Gastos por tarjeta',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          SizedBox(height: 220, child: _PieFromTuples(data: byCard)),
        ],
      ),
    );
  }
}

class _MonthBarChart extends StatelessWidget {
  const _MonthBarChart({required this.data});

  final List<(String month, double value)> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('Sin datos'));
    }

    final maxY = data
        .map((item) => item.$2)
        .fold<double>(0, (a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        maxY: maxY == 0 ? 100 : maxY * 1.15,
        barGroups: [
          for (var i = 0; i < data.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [BarChartRodData(toY: data[i].$2)],
            ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= data.length) {
                  return const SizedBox.shrink();
                }
                return Text(
                  data[index].$1.substring(5),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
      ),
    );
  }
}

class _PieFromTuples extends StatelessWidget {
  const _PieFromTuples({required this.data});

  final List<(String label, double value)> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('Sin datos'));
    }

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 28,
        sections: [
          for (var i = 0; i < data.length; i++)
            PieChartSectionData(
              value: data[i].$2,
              title: data[i].$1,
              radius: 42,
              color: Colors.accents[i % Colors.accents.length],
              titleStyle: const TextStyle(fontSize: 11, color: Colors.white),
            ),
        ],
      ),
    );
  }
}
