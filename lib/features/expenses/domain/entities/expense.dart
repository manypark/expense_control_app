class ExpenseEntity {
  const ExpenseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.amount,
    required this.incurredAt,
    this.creditCardId,
    this.receiptPath,
    required this.statementYear,
    required this.statementMonth,
  });

  final int id;
  final String title;
  final String description;
  final String category;
  final double amount;
  final DateTime incurredAt;
  final int? creditCardId;
  final String? receiptPath;
  final int statementYear;
  final int statementMonth;
}
