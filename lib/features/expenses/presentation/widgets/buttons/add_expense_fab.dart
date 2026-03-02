import 'package:flutter/material.dart';

class AddExpenseFab extends StatelessWidget {
  const AddExpenseFab({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: const Text('Agregar gasto'),
    );
  }
}
