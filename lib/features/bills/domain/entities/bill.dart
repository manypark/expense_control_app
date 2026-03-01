class BillEntity {
  const BillEntity({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.isPaid,
  });

  final String id;
  final String title;
  final DateTime dueDate;
  final bool isPaid;
}
