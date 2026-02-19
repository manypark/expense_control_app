import 'package:expense_control_app/features/expenses/domain/entities/expense.dart';
import 'package:expense_control_app/features/expenses/infrastructure/dtos/expense_model.dart';
import 'package:isar/isar.dart';

class ExpenseMapper {
  ExpenseEntity toEntity(ExpenseModel model) {
    return ExpenseEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      category: model.category,
      amount: model.amount,
      incurredAt: model.incurredAt,
      creditCardId: model.creditCardId,
      receiptPath: model.receiptPath,
      statementYear: model.statementYear,
      statementMonth: model.statementMonth,
    );
  }

  ExpenseModel toModel(ExpenseEntity entity) {
    final model = ExpenseModel()
      ..id = entity.id <= 0 ? Isar.autoIncrement : entity.id
      ..title = entity.title
      ..description = entity.description
      ..category = entity.category
      ..amount = entity.amount
      ..incurredAt = entity.incurredAt
      ..creditCardId = entity.creditCardId
      ..receiptPath = entity.receiptPath
      ..statementYear = entity.statementYear
      ..statementMonth = entity.statementMonth;

    return model;
  }
}
