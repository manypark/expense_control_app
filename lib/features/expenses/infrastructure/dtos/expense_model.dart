import 'package:isar/isar.dart';

part 'expense_model.g.dart';

@collection
class ExpenseModel {
  Id id = Isar.autoIncrement;

  late String title;
  late String description;
  late String category;
  late double amount;
  late DateTime incurredAt;

  int? creditCardId;
  String? receiptPath;

  @Index(composite: [CompositeIndex('statementMonth')])
  late int statementYear;

  late int statementMonth;
}
