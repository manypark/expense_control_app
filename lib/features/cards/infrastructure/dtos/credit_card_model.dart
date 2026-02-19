import 'package:isar/isar.dart';

part 'credit_card_model.g.dart';

@collection
class CreditCardModel {
  Id id = Isar.autoIncrement;

  late String alias;
  late String bank;
  late String last4;
  late int closingDay;
  late int dueDay;
  late double creditLimit;
}
