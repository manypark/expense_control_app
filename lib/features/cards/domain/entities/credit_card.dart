class CreditCardEntity {
  const CreditCardEntity({
    required this.id,
    required this.alias,
    required this.bank,
    required this.last4,
    required this.closingDay,
    required this.dueDay,
    required this.creditLimit,
  });

  final String id;
  final String alias;
  final String bank;
  final String last4;
  final int closingDay;
  final int dueDay;
  final double creditLimit;

  String get label => '$alias ($last4)';
}
