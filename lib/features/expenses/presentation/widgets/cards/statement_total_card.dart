import 'package:flutter/material.dart';

class StatementTotalCard extends StatelessWidget {
  const StatementTotalCard({super.key, required this.totalText});

  final String totalText;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Gasto del corte actual de tarjetas'),
        subtitle: const Text(
          'Este monto depende del dia de cierre configurado por tarjeta',
        ),
        trailing: Text(totalText),
      ),
    );
  }
}
