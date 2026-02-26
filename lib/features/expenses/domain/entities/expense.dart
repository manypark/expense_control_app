class ExpenseEntity {
  const ExpenseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.amount,
    required this.incurredAt,
    this.creditCardId,
    required this.statementYear,
    required this.statementMonth,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final double amount;
  final DateTime incurredAt;
  final String? creditCardId;
  final int statementYear;
  final int statementMonth;
}
