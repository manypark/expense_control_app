import 'package:flutter/material.dart';

class AddAccountAppBarButton extends StatelessWidget {
  const AddAccountAppBarButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      tooltip: 'Agregar cuenta',
    );
  }
}
