import 'package:flutter/material.dart';

class AppNavItem {
  const AppNavItem({
    required this.label,
    required this.icon,
    required this.page,
  });

  final String label;
  final IconData icon;
  final Widget page;

  NavigationDestination toMaterialDestination() {
    return NavigationDestination(icon: Icon(icon), label: label);
  }

  BottomNavigationBarItem toCupertinoItem() {
    return BottomNavigationBarItem(
      icon: Icon(icon), 
      label: label,
    );
  }
}
