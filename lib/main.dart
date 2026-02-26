import 'dart:convert';

import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_control_app/shared/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final baseUrl = await _resolveBaseUrl();
  runApp(
    ProviderScope(
      overrides: [apiBaseUrlProvider.overrideWith((ref) => baseUrl)],
      child: const ExpenseControlApp(),
    ),
  );
}

Future<String> _resolveBaseUrl() async {
  const fallback = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://expense-control-back.onrender.com',
  );

  try {
    final raw = await rootBundle.loadString('assets/env/dev.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final value = json['API_BASE_URL'] as String?;
    if (value != null && value.isNotEmpty) {
      return value;
    }
  } catch (_) {
    return fallback;
  }

  return fallback;
}
