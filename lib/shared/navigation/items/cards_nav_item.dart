import 'package:flutter/material.dart';

import 'package:expense_control_app/features/cards/presentation/screens/cards_screen.dart';
import 'package:expense_control_app/shared/navigation/app_nav_item.dart';

const cardsNavItem = AppNavItem(
  label: 'Tarjetas',
  icon: Icons.credit_card_outlined,
  page: CardsScreen(),
);
