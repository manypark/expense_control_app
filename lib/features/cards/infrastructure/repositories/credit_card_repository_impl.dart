import 'package:expense_control_app/features/cards/domain/entities/credit_card.dart';
import 'package:expense_control_app/features/cards/domain/repositories/credit_card_repository.dart';
import 'package:expense_control_app/features/cards/infrastructure/datasource/credit_card_local_datasource.dart';
import 'package:expense_control_app/features/cards/infrastructure/mappers/credit_card_mapper.dart';

class CreditCardRepositoryImpl implements CreditCardRepository {
  CreditCardRepositoryImpl(this._dataSource, this._mapper);

  final CreditCardLocalDataSource _dataSource;
  final CreditCardMapper _mapper;

  @override
  Future<void> saveCard(CreditCardEntity card) {
    return _dataSource.save(_mapper.toModel(card));
  }

  @override
  Stream<List<CreditCardEntity>> watchCards() {
    return _dataSource.watchCards().map(
      (models) => models.map(_mapper.toEntity).toList(growable: false),
    );
  }
}
