import 'package:flutter/material.dart';

import 'package:expense_control_app/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:expense_control_app/shared/navigation/app_nav_item.dart';

const analyticsNavItem = AppNavItem(
  label: 'Analitica',
  icon: Icons.analytics_outlined,
  page: AnalyticsScreen(),
);
