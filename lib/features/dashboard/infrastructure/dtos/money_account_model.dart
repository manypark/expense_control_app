import 'package:isar/isar.dart';

part 'money_account_model.g.dart';

@collection
class MoneyAccountModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String code;

  late String name;
  late double balance;
}
