class MoneyAccountEntity {
  const MoneyAccountEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.balance,
  });

  final String id;
  final String code;
  final String name;
  final double balance;

  MoneyAccountEntity copyWith({double? balance}) {
    return MoneyAccountEntity(
      id: id,
      code: code,
      name: name,
      balance: balance ?? this.balance,
    );
  }
}
