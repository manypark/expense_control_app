import 'package:flutter/cupertino.dart';
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
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        minimumSize: const Size.square(28),
        onPressed: onPressed,
        child: Icon(
          isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: 22,
        ),
      );
    }
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      ),
      tooltip: isVisible ? 'Ocultar monto' : 'Mostrar monto',
    );
  }
}
