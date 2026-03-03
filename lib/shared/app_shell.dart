import 'package:flutter/material.dart';

import 'package:expense_control_app/shared/navigation/navigation.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  static const _navItems = [
    homeNavItem,
    expensesNavItem,
    billsNavItem,
    analyticsNavItem,
    cardsNavItem,
    sessionNavItem,
  ];

  @override
  Widget build(BuildContext context) {

    final pages = _navItems.map( (item) => item.page ).toList(growable:false);

    return Scaffold(
      extendBody: true,
      body      : IndexedStack(
        index   : _currentIndex, 
        children: pages,
      ),
      bottomNavigationBar: AdaptiveBottomNavigation(
        items       : _navItems,
        currentIndex: _currentIndex,
        onTap       : (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
