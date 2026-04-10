import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';

class ExpenseFeedFilters {
  const ExpenseFeedFilters({this.category, this.from, this.to});

  final String? category;
  final DateTime? from;
  final DateTime? to;

  bool get hasFilters => category != null || from != null || to != null;

  ExpenseFeedFilters copyWith({
    String? category,
    DateTime? from,
    DateTime? to,
    bool clearCategory = false,
    bool clearFrom = false,
    bool clearTo = false,
  }) {
    return ExpenseFeedFilters(
      category: clearCategory ? null : (category ?? this.category),
      from: clearFrom ? null : (from ?? this.from),
      to: clearTo ? null : (to ?? this.to),
    );
  }
}

class ExpenseFeedState {
  const ExpenseFeedState({
    required this.items,
    required this.filters,
    required this.hasMore,
    required this.isLoadingMore,
  });

  final List<ExpenseEntity> items;
  final ExpenseFeedFilters filters;
  final bool hasMore;
  final bool isLoadingMore;

  double get total => items.fold(0, (sum, item) => sum + item.amount);

  ExpenseFeedState copyWith({
    List<ExpenseEntity>? items,
    ExpenseFeedFilters? filters,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return ExpenseFeedState(
      items: items ?? this.items,
      filters: filters ?? this.filters,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
