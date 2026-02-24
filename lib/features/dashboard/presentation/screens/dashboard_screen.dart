import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/dashboard/domain/entities/entities.dart';
import 'package:expense_control_app/features/dashboard/presentation/presentation.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(dashboardAccountsProvider);
    final total = ref.watch(totalMoneyProvider);
    final currency = NumberFormat.currency(locale: 'es_MX', symbol: r'$');

    return Scaffold(
      body: accountsAsync.when(
        data: (accounts) {
          return CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              const SliverAppBar(pinned: true),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList.list(
                  children: [
                    const Text(
                      'Total disponible',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currency.format(total),
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 220,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: _AccountsPieChart(accounts: accounts),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Bancos y fintech',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (final account in accounts)
                      Card(
                        child: ListTile(
                          title: Text(account.name),
                          subtitle: Text(account.code),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(currency.format(account.balance)),
                              IconButton(
                                onPressed: () => _confirmDeleteAccount(
                                  context,
                                  ref,
                                  account,
                                ),
                                icon: const Icon(Icons.delete_outline),
                                tooltip: 'Eliminar',
                              ),
                            ],
                          ),
                          onTap: () =>
                              _showAccountForm(context, ref, account: account),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAccountForm(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Agregar cuenta'),
      ),
    );
  }

  Future<void> _showAccountForm(
    BuildContext context,
    WidgetRef ref, {
    MoneyAccountEntity? account,
  }) async {
    final codeController = TextEditingController(text: account?.code ?? '');
    final nameController = TextEditingController(text: account?.name ?? '');
    final balanceController = TextEditingController(
      text: (account?.balance ?? 0).toStringAsFixed(2),
    );

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                account == null ? 'Nueva cuenta' : 'Editar cuenta',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre visible'),
              ),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: 'Codigo interno (unico)',
                ),
              ),
              TextField(
                controller: balanceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Monto actual'),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    final entity = MoneyAccountEntity(
                      id: account?.id ?? '',
                      code: codeController.text.trim(),
                      name: nameController.text.trim(),
                      balance:
                          double.tryParse(balanceController.text.trim()) ?? 0,
                    );

                    await ref
                        .read(accountCommandsProvider.notifier)
                        .upsertAccount(entity);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmDeleteAccount(
    BuildContext context,
    WidgetRef ref,
    MoneyAccountEntity account,
  ) async {
    final accepted = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar cuenta'),
          content: Text(
            'Se eliminara ${account.name}. Esta accion no se puede deshacer.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (accepted == true) {
      await ref
          .read(accountCommandsProvider.notifier)
          .deleteAccount(account.id);
    }
  }
}

class _AccountsPieChart extends StatelessWidget {
  const _AccountsPieChart({required this.accounts});

  final List<MoneyAccountEntity> accounts;

  @override
  Widget build(BuildContext context) {
    final total = accounts.fold<double>(
      0,
      (sum, account) => sum + account.balance,
    );

    if (total <= 0) {
      return const Center(child: Text('Agrega montos para ver la grafica'));
    }

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 32,
        sections: [
          for (var i = 0; i < accounts.length; i++)
            PieChartSectionData(
              value: accounts[i].balance,
              title: accounts[i].name,
              radius: 42,
              color: Colors.primaries[i % Colors.primaries.length],
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
