import 'package:flutter/material.dart';

class ExpenseFeedSummaryCard extends StatelessWidget {
  const ExpenseFeedSummaryCard({
    super.key,
    required this.totalText,
    required this.count,
  });

  final String totalText;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Gastos cargados'),
        subtitle: Text('$count registros en pantalla'),
        trailing: Text(totalText),
      ),
    );
  }
}
