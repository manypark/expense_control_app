import 'package:flutter/material.dart';

import 'package:expense_control_app/shared/navigation/app_nav_item.dart';
import 'package:expense_control_app/shared/session_screen.dart';

const sessionNavItem = AppNavItem(
  label: 'Cuenta',
  icon: Icons.person_outline,
  page: SessionScreen(),
);
