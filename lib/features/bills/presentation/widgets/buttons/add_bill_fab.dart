import 'package:flutter/material.dart';

class AddBillFab extends StatelessWidget {
  const AddBillFab({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: const Text('Agregar servicio'),
    );
  }
}
