class AppConstants {
  static const List<DefaultAccountSeed> defaultMoneyAccounts = [
    DefaultAccountSeed(code: 'cash', name: 'Efectivo'),
    DefaultAccountSeed(code: 'hsbc_bank', name: 'HSBC'),
    DefaultAccountSeed(code: 'fintech', name: 'Bitso'),
    DefaultAccountSeed(code: 'nu_bank', name: 'NU'),
    DefaultAccountSeed(code: 'mp_bank', name: 'Mercado Pago'),
  ];

  static const List<String> expenseCategories = [
    'Alimentos',
    'Transporte',
    'Servicios',
    'Entretenimiento',
    'Salud',
    'Compras',
    'Educacion',
    'Viajes',
    'Otros',
  ];
}

class DefaultAccountSeed {
  const DefaultAccountSeed({required this.code, required this.name});

  final String code;
  final String name;
}
