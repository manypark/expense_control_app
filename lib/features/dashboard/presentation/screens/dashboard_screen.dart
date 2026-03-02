import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/dashboard/domain/entities/entities.dart';
import 'package:expense_control_app/features/dashboard/presentation/presentation.dart';

class DashboardScreen extends ConsumerWidget {

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final total = ref.watch(totalMoneyProvider);
    final accountsAsync = ref.watch(dashboardAccountsProvider);
    final currency = NumberFormat.currency(locale: 'es_MX', symbol: r'$');
    final isTotalVisible = ref.watch(totalAmountVisibilityProvider).valueOrNull ?? true;

    return Scaffold(
      body: accountsAsync.when(
        data    : (accounts) {

          return CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned  : true,
                title   : const Text('Inicio'),
                actions : [
                  AddAccountAppBarButton( onPressed: () => _openAccountForm(context), ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const TotalAvailableTitleText(),
                          const SizedBox(width: 8),
                          ToggleTotalVisibilityButton(
                            isVisible: isTotalVisible,
                            onPressed: () => ref.read(totalAmountVisibilityProvider.notifier).toggle(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TotalAmountText(
                        totalAmount: currency.format(total),
                        isVisible: isTotalVisible,
                      ),
                      const SizedBox(height: 20),
                      AccountsPieChartCard(accounts: accounts),
                      const SizedBox(height: 16),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: AccountsSectionTitleText(),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: MoneyAccountsSliverList(
                  accounts: accounts,
                  currency: currency,
                  onEdit: (account) => _openAccountForm(context, account),
                  onDelete: (account) =>
                      showDeleteAccountDialog(context, ref, account),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          );
        },
        loading : () => const Center(child: CircularProgressIndicator()),
        error   : (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _openAccountForm(BuildContext context, [MoneyAccountEntity? account]) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => AccountFormSheet(account: account),
    );
  }
}