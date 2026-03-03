import 'package:flutter/material.dart';

import 'package:expense_control_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:expense_control_app/shared/navigation/app_nav_item.dart';

const homeNavItem = AppNavItem(
  label: 'Inicio',
  icon: Icons.home_outlined,
  page: DashboardScreen(),
);
