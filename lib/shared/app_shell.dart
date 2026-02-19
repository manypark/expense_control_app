import 'package:expense_control_app/features/analytics/presentation/screens/analytics_screen.dart';
import 'package:expense_control_app/features/cards/presentation/screens/cards_screen.dart';
import 'package:expense_control_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:expense_control_app/features/expenses/presentation/screens/expenses_screen.dart';
import 'package:flutter/material.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final _pages = const [
    DashboardScreen(),
    ExpensesScreen(),
    AnalyticsScreen(),
    CardsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Gastos',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Analitica',
          ),
          NavigationDestination(
            icon: Icon(Icons.credit_card_outlined),
            label: 'Tarjetas',
          ),
        ],
      ),
    );
  }
}
