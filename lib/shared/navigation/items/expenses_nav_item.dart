import 'package:flutter/material.dart';

import 'package:expense_control_app/features/expenses/presentation/screens/expenses_screen.dart';
import 'package:expense_control_app/shared/navigation/app_nav_item.dart';

const expensesNavItem = AppNavItem(
  label: 'Gastos',
  icon: Icons.receipt_long_outlined,
  page: ExpensesScreen(),
);
