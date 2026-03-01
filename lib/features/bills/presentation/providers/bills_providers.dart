import 'package:expense_control_app/core/services/app_providers.dart';
import 'package:expense_control_app/features/bills/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bills_providers.g.dart';

enum BillDueStatus { green, yellow, red }

@riverpod
Future<List<BillEntity>> allBills(AllBillsRef ref) {
  return ref.watch(billsStreamProvider.future);
}

@riverpod
Map<String, BillDueStatus> billDueStatusById(BillDueStatusByIdRef ref) {
  final bills = ref.watch(allBillsProvider).valueOrNull ?? const <BillEntity>[];
  final today = DateUtils.dateOnly(DateTime.now());

  return {
    for (final bill in bills) bill.id: _resolveStatus(bill, today),
  };
}

BillDueStatus _resolveStatus(BillEntity bill, DateTime today) {
  if (bill.isPaid) return BillDueStatus.green;

  final dueDate = DateUtils.dateOnly(bill.dueDate);
  final daysUntilDue = dueDate.difference(today).inDays;

  if (daysUntilDue <= 3) return BillDueStatus.red;
  if (daysUntilDue < 5) return BillDueStatus.yellow;
  return BillDueStatus.green;
}
