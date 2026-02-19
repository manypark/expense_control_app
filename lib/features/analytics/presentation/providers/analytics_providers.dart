import 'package:expense_control_app/features/cards/presentation/providers/cards_providers.dart';
import 'package:expense_control_app/features/expenses/presentation/providers/expenses_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_providers.g.dart';

@riverpod
List<(String label, double value)> spendingByCategory(
  SpendingByCategoryRef ref,
) {
  final totals = ref.watch(categoryExpenseTotalsProvider);
  return totals.entries
      .map((entry) => (entry.key, entry.value))
      .toList(growable: false);
}

@riverpod
List<(String label, double value)> spendingByCard(SpendingByCardRef ref) {
  final totals = ref.watch(cardExpenseTotalsProvider);
  final cards = ref.watch(cardsByIdProvider);

  return totals.entries
      .map(
        (entry) =>
            (cards[entry.key]?.label ?? 'Tarjeta ${entry.key}', entry.value),
      )
      .toList(growable: false);
}

@riverpod
List<(String month, double value)> spendingByMonth(SpendingByMonthRef ref) {
  final totals = ref.watch(monthlyExpenseTotalsProvider);
  final sorted = totals.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  return sorted
      .map((entry) => (entry.key, entry.value))
      .toList(growable: false);
}
