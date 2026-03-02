import 'package:flutter/material.dart';

class ToggleTotalVisibilityButton extends StatelessWidget {
  const ToggleTotalVisibilityButton({
    super.key,
    required this.isVisible,
    required this.onPressed,
  });

  final bool isVisible;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      ),
      tooltip: isVisible ? 'Ocultar monto' : 'Mostrar monto',
    );
  }
}
