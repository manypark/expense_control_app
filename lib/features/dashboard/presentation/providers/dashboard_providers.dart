import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/dashboard/domain/entities/money_account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_providers.g.dart';

@riverpod
AsyncValue<List<MoneyAccountEntity>> dashboardAccounts(
  DashboardAccountsRef ref,
) {
  return ref.watch(accountsStreamProvider);
}

@riverpod
double totalMoney(TotalMoneyRef ref) {
  final accounts = ref.watch(dashboardAccountsProvider).valueOrNull ?? const [];
  return accounts.fold<double>(0, (sum, account) => sum + account.balance);
}
