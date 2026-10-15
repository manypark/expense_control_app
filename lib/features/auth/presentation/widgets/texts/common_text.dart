import 'package:flutter/material.dart';

class CommonTexts extends StatelessWidget {

  final String title;
  final TextStyle? style;

  const CommonTexts({
    super.key,
    required this.title,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style ?? const TextStyle(
        fontSize  : 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}