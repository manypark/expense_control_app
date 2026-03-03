import 'package:flutter/material.dart';

import 'package:expense_control_app/shared/navigation/app_nav_item.dart';

import 'cupertino_bottom_navigation.dart';
import 'material_bottom_navigation.dart';

class AdaptiveBottomNavigation extends StatelessWidget {
  const AdaptiveBottomNavigation({
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
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      return CupertinoBottomNavigation(
        items       : items,
        currentIndex: currentIndex,
        onTap       : onTap,
      );
    }
    return MaterialBottomNavigation(
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
