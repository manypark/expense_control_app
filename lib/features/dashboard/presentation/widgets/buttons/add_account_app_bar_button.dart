import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAccountAppBarButton extends StatelessWidget {
  const AddAccountAppBarButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        minimumSize: const Size.square(28),
        onPressed: onPressed,
        child: const Icon(Icons.add),
      );
    }
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      tooltip: 'Agregar cuenta',
    );
  }
}
