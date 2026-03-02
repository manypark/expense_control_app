import 'package:flutter/material.dart';

class TotalAmountText extends StatelessWidget {
  const TotalAmountText({
    super.key,
    required this.totalAmount,
    required this.isVisible,
  });

  final String totalAmount;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Text(
      isVisible ? totalAmount : r'$***.***',
      style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
    );
  }
}
