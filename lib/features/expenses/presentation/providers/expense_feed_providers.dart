import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/core/services/http_client_service.dart';
import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';

import 'expense_feed_state.dart';

part 'expense_feed_providers.g.dart';

class ExpenseMonthSummary {
  const ExpenseMonthSummary({
    required this.label,
    required this.total,
    required this.previousTotal,
  });

  final String label;
  final double total;
  final double previousTotal;

  double? get changeRatio {
    if (previousTotal <= 0) return null;
    return (total - previousTotal) / previousTotal;
  }
}

final expenseMonthSummaryProvider = FutureProvider<ExpenseMonthSummary>((ref) {
  final api = ref.read(apiClientProvider);
  return _fetchMonthSummary(api);
});

@riverpod
class ExpenseFeedController extends _$ExpenseFeedController {
  static const _initialLimit = 20;
  static const _nextLimit = 10;

  @override
  Future<ExpenseFeedState> build() => _fetchPage();

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || current.isLoadingMore || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final next = await _fetchPage(
        filters: current.filters,
        offset: current.items.length,
        limit: _nextLimit,
      );
      state = AsyncData(
        current.copyWith(
          items: [...current.items, ...next.items],
          hasMore: next.hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
      rethrow;
    }
  }

  Future<void> setCategory(String? category) async {
    final filters = (state.valueOrNull?.filters ?? const ExpenseFeedFilters())
        .copyWith(category: category, clearCategory: category == null);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage(filters: filters));
  }

  Future<void> setDateRange(DateTimeRange? range) async {
    final current = state.valueOrNull?.filters ?? const ExpenseFeedFilters();
    final filters = current.copyWith(
      from: range?.start,
      to: range?.end,
      clearFrom: range == null,
      clearTo: range == null,
    );
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage(filters: filters));
  }

  Future<void> clearFilters() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage());
  }

  Future<void> refresh() async {
    final filters = state.valueOrNull?.filters ?? const ExpenseFeedFilters();
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage(filters: filters));
    ref.invalidate(expenseMonthSummaryProvider);
  }

  Future<ExpenseFeedState> _fetchPage({
    ExpenseFeedFilters filters = const ExpenseFeedFilters(),
    int offset = 0,
    int limit = _initialLimit,
  }) async {
    final api = ref.read(apiClientProvider);
    final query = _buildQuery(filters: filters, offset: offset, limit: limit);
    final json =
        await api.get(path: '/expenses?$query') as Map<String, dynamic>;
    final items = (json['items'] as List<dynamic>)
        .map((item) => _expenseFromJson(item as Map<String, dynamic>))
        .toList(growable: false);
    return ExpenseFeedState(
      items: items,
      filters: filters,
      hasMore: json['hasMore'] as bool? ?? false,
      isLoadingMore: false,
    );
  }

  String _buildQuery({
    required ExpenseFeedFilters filters,
    required int offset,
    required int limit,
  }) {
    final params = <String, String>{'offset': '$offset', 'limit': '$limit'};
    if (filters.category != null) {
      params['category'] = filters.category!;
    }
    if (filters.from != null) {
      params['from'] = DateFormat('yyyy-MM-dd').format(filters.from!);
    }
    if (filters.to != null) {
      params['to'] = DateFormat('yyyy-MM-dd').format(filters.to!);
    }
    return Uri(queryParameters: params).query;
  }
}

ExpenseEntity _expenseFromJson(Map<String, dynamic> json) {
  return ExpenseEntity(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
    amount: (json['amount'] as num).toDouble(),
    incurredAt: DateTime.parse(json['incurredAt'] as String),
    creditCardId: json['creditCardId'] as String?,
    statementYear: json['statementYear'] as int,
    statementMonth: json['statementMonth'] as int,
  );
}

Future<ExpenseMonthSummary> _fetchMonthSummary(HttpClientService api) async {
  final now = DateTime.now();
  final currentStart = DateTime(now.year, now.month);
  final currentEnd = DateTime(now.year, now.month + 1, 0);
  final previousStart = DateTime(now.year, now.month - 1);
  final previousEnd = DateTime(now.year, now.month, 0);

  final currentTotal = await _fetchRangeTotal(api, currentStart, currentEnd);
  final previousTotal = await _fetchRangeTotal(api, previousStart, previousEnd);

  return ExpenseMonthSummary(
    label: DateFormat('MMMM', 'es_MX').format(now).toUpperCase(),
    total: currentTotal,
    previousTotal: previousTotal,
  );
}

Future<double> _fetchRangeTotal(
  HttpClientService api,
  DateTime from,
  DateTime to,
) async {
  final query = Uri(
    queryParameters: {
      'offset': '0',
      'limit': '500',
      'from': DateFormat('yyyy-MM-dd').format(from),
      'to': DateFormat('yyyy-MM-dd').format(to),
    },
  ).query;
  final json = await api.get(path: '/expenses?$query') as Map<String, dynamic>;
  final items = json['items'] as List<dynamic>? ?? const [];
  return items.fold<double>(0, (sum, item) {
    final amount = (item as Map<String, dynamic>)['amount'] as num;
    return sum + amount.toDouble();
  });
}
