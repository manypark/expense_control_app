import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expense_control_app/shared/navigation/app_nav_item.dart';

class CupertinoBottomNavigation extends StatelessWidget {
  const CupertinoBottomNavigation({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<AppNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const radius = BorderRadius.all( Radius.circular(30) );
    return SafeArea(
      minimum : const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child   : DecoratedBox(
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.screen,
          color       : Colors.transparent,
          borderRadius: radius,
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: CupertinoTabBar(
            currentIndex: currentIndex,
            onTap: onTap,
            backgroundColor: Colors.transparent,
            iconSize: 25,
            activeColor: colorScheme.primary,
            inactiveColor: colorScheme.outline,
            border: Border.all(color: colorScheme.outlineVariant, width: 0),
            items: [
              for (final item in items) item.toCupertinoItem()
            ],
          ),
        ),
      ),
    );
  }
}
