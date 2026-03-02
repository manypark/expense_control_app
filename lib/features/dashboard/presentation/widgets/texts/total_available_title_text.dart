import 'package:flutter/material.dart';

class TotalAvailableTitleText extends StatelessWidget {
  const TotalAvailableTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Total disponible',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}
