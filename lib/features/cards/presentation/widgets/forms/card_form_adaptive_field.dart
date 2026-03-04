import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardFormAdaptiveField extends StatelessWidget {
  const CardFormAdaptiveField({
    super.key,
    required this.controller,
    required this.label,
    required this.isIOS,
    this.keyboardType,
    this.maxLength,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String label;
  final bool isIOS;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: CupertinoTextField(
          controller: controller,
          placeholder: label,
          keyboardType: keyboardType,
          maxLength: maxLength,
          enabled: enabled,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      );
    }

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      enabled: enabled,
      decoration: InputDecoration(labelText: label),
    );
  }
}
