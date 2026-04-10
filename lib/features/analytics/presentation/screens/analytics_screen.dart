import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:expense_control_app/features/analytics/presentation/providers/analytics_providers.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final byMonth = ref.watch(spendingByMonthProvider);
    final byCategory = ref.watch(spendingByCategoryProvider);
    final byCard = ref.watch(spendingByCardProvider);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          const SliverAppBar(pinned: true, title: Text('Analitica')),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.list(
              children: [
                _AnalyticsSection(
                  title: 'Gastos por mes',
                  child: _MonthBarList(data: byMonth),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 16),
                _AnalyticsSection(
                  title: 'Gastos por categoria',
                  child: _ValueBarList(data: byCategory),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 16),
                _AnalyticsSection(
                  title: 'Gastos por tarjeta',
                  child: _ValueBarList(data: byCard),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: height * 0.14)),
        ],
      ),
    );
  }
}

class _MonthBarList extends StatelessWidget {
  const _MonthBarList({required this.data});

  final List<(String month, double value)> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('Sin datos'));
    }

    final currency = NumberFormat.currency(locale: 'es_MX', symbol: r'$');
    final maxValue = data.fold<double>(
      0,
      (max, item) => item.$2 > max ? item.$2 : max,
    );

    return Column(
      children: [
        for (var i = 0; i < data.length; i++)
          _ValueBarRow(
            label: _monthLabel(data[i].$1),
            amountText: currency.format(data[i].$2),
            ratio: maxValue == 0 ? 0 : data[i].$2 / maxValue,
            color: _monthPalette[i % _monthPalette.length],
          ),
      ],
    );
  }

  String _monthLabel(String value) {
    final date = DateTime.tryParse('$value-01');
    if (date == null) return value;
    final label = DateFormat('MMMM yyyy', 'es_MX').format(date);
    return '${label[0].toUpperCase()}${label.substring(1)}';
  }
}

class _ValueBarList extends StatelessWidget {
  const _ValueBarList({required this.data});

  final List<(String label, double value)> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('Sin datos'));
    }

    final currency = NumberFormat.currency(locale: 'es_MX', symbol: r'$');
    final maxValue = data.fold<double>(
      0,
      (max, item) => item.$2 > max ? item.$2 : max,
    );

    return Column(
      children: [
        for (var i = 0; i < data.length; i++)
          _ValueBarRow(
            label: data[i].$1,
            amountText: currency.format(data[i].$2),
            ratio: maxValue == 0 ? 0 : data[i].$2 / maxValue,
            color: _monthPalette[i % _monthPalette.length],
          ),
      ],
    );
  }
}

class _ValueBarRow extends StatelessWidget {
  const _ValueBarRow({
    required this.label,
    required this.amountText,
    required this.ratio,
    required this.color,
  });

  final String label;
  final String amountText;
  final double ratio;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
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
              value: ratio.clamp(0.0, 1.0),
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

class _AnalyticsSection extends StatelessWidget {
  const _AnalyticsSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: isIOS
              ? BoxDecoration(
                  color: Colors.black12.withAlpha(10),
                  borderRadius: BorderRadius.circular(14),
                )
              : null,
          child: Card(
            elevation: isIOS ? 0 : null,
            color: isIOS ? Colors.transparent : null,
            child: Padding(padding: const EdgeInsets.all(16), child: child),
          ),
        ),
      ],
    );
  }
}

const _monthPalette = <Color>[
  Color(0xFF0F766E),
  Color(0xFF2563EB),
  Color(0xFFDC2626),
  Color(0xFFF59E0B),
  Color(0xFF7C3AED),
  Color(0xFF0891B2),
];
