import 'package:expense_control_app/shared/app_shell.dart';
import 'package:flutter/material.dart';

class ExpenseControlApp extends StatelessWidget {
  const ExpenseControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Control',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const AppShell(),
    );
  }
}
