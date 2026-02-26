import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_control_app/features/expenses/infrastructure/dtos/expense_model.dart';
import 'package:isar/isar.dart';

class ExpenseMapper {
  ExpenseEntity toEntity(ExpenseModel model) {
    return ExpenseEntity(
      id: model.id.toString(),
      title: model.title,
      description: model.description,
      category: model.category,
      amount: model.amount,
      incurredAt: model.incurredAt,
      creditCardId: model.creditCardId?.toString(),
      statementYear: model.statementYear,
      statementMonth: model.statementMonth,
    );
  }

  ExpenseModel toModel(ExpenseEntity entity) {
    final parsedId = int.tryParse(entity.id);
    final parsedCardId = int.tryParse(entity.creditCardId ?? '');
    final model = ExpenseModel()
      ..id = (parsedId == null || parsedId <= 0) ? Isar.autoIncrement : parsedId
      ..title = entity.title
      ..description = entity.description
      ..category = entity.category
      ..amount = entity.amount
      ..incurredAt = entity.incurredAt
      ..creditCardId = parsedCardId
      ..statementYear = entity.statementYear
      ..statementMonth = entity.statementMonth;

    return model;
  }
}
