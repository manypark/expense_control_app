import 'package:flutter/material.dart';

import 'package:expense_control_app/features/bills/presentation/screens/bills_screen.dart';
import 'package:expense_control_app/shared/navigation/app_nav_item.dart';

const billsNavItem = AppNavItem(
  label: 'Servicios',
  icon: Icons.bar_chart_outlined,
  page: BillsScreen(),
);
