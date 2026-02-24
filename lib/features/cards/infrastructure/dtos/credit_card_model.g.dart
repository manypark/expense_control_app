// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCreditCardModelCollection on Isar {
  IsarCollection<CreditCardModel> get creditCardModels => this.collection();
}

const CreditCardModelSchema = CollectionSchema(
  name: r'CreditCardModel',
  id: 5536749382818049299,
  properties: {
    r'alias': PropertySchema(
      id: 0,
      name: r'alias',
      type: IsarType.string,
    ),
    r'bank': PropertySchema(
      id: 1,
      name: r'bank',
      type: IsarType.string,
    ),
    r'closingDay': PropertySchema(
      id: 2,
      name: r'closingDay',
      type: IsarType.long,
    ),
    r'creditLimit': PropertySchema(
      id: 3,
      name: r'creditLimit',
      type: IsarType.double,
    ),
    r'dueDay': PropertySchema(
      id: 4,
      name: r'dueDay',
      type: IsarType.long,
    ),
    r'last4': PropertySchema(
      id: 5,
      name: r'last4',
      type: IsarType.string,
    )
  },
  estimateSize: _creditCardModelEstimateSize,
  serialize: _creditCardModelSerialize,
  deserialize: _creditCardModelDeserialize,
  deserializeProp: _creditCardModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _creditCardModelGetId,
  getLinks: _creditCardModelGetLinks,
  attach: _creditCardModelAttach,
  version: '3.1.0+1',
);

int _creditCardModelEstimateSize(
  CreditCardModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.alias.length * 3;
  bytesCount += 3 + object.bank.length * 3;
  bytesCount += 3 + object.last4.length * 3;
  return bytesCount;
}

void _creditCardModelSerialize(
  CreditCardModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.alias);
  writer.writeString(offsets[1], object.bank);
  writer.writeLong(offsets[2], object.closingDay);
  writer.writeDouble(offsets[3], object.creditLimit);
  writer.writeLong(offsets[4], object.dueDay);
  writer.writeString(offsets[5], object.last4);
}

CreditCardModel _creditCardModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CreditCardModel();
  object.alias = reader.readString(offsets[0]);
  object.bank = reader.readString(offsets[1]);
  object.closingDay = reader.readLong(offsets[2]);
  object.creditLimit = reader.readDouble(offsets[3]);
  object.dueDay = reader.readLong(offsets[4]);
  object.id = id;
  object.last4 = reader.readString(offsets[5]);
  return object;
}

P _creditCardModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _creditCardModelGetId(CreditCardModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _creditCardModelGetLinks(CreditCardModel object) {
  return [];
}

void _creditCardModelAttach(
    IsarCollection<dynamic> col, Id id, CreditCardModel object) {
  object.id = id;
}

extension CreditCardModelQueryWhereSort
    on QueryBuilder<CreditCardModel, CreditCardModel, QWhere> {
  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CreditCardModelQueryWhere
    on QueryBuilder<CreditCardModel, CreditCardModel, QWhereClause> {
  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CreditCardModelQueryFilter
    on QueryBuilder<CreditCardModel, CreditCardModel, QFilterCondition> {
  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      aliasEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      aliasGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'alias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      aliasLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'alias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      aliasBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'alias',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      aliasStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'alias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      aliasEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'alias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      aliasContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'alias',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      aliasMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'alias',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      aliasIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alias',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      aliasIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'alias',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      bankEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bank',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      bankGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bank',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      bankLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bank',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      bankBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bank',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      bankStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bank',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      bankEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bank',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      bankContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bank',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      bankMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bank',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      bankIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bank',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      bankIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bank',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      closingDayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'closingDay',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      closingDayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'closingDay',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      closingDayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'closingDay',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      closingDayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'closingDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      creditLimitEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creditLimit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      creditLimitGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creditLimit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      creditLimitLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creditLimit',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      creditLimitBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creditLimit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      dueDayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueDay',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      dueDayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dueDay',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      dueDayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dueDay',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      dueDayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dueDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      last4EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'last4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      last4GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'last4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      last4LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'last4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      last4Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'last4',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      last4StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'last4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      last4EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'last4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      last4Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'last4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      last4Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'last4',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      last4IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'last4',
        value: '',
      ));
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterFilterCondition>
      last4IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'last4',
        value: '',
      ));
    });
  }
}

extension CreditCardModelQueryObject
    on QueryBuilder<CreditCardModel, CreditCardModel, QFilterCondition> {}

extension CreditCardModelQueryLinks
    on QueryBuilder<CreditCardModel, CreditCardModel, QFilterCondition> {}

extension CreditCardModelQuerySortBy
    on QueryBuilder<CreditCardModel, CreditCardModel, QSortBy> {
  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> sortByAlias() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alias', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByAliasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alias', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> sortByBank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bank', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByBankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bank', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByClosingDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'closingDay', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByClosingDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'closingDay', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByCreditLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimit', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByCreditLimitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimit', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> sortByDueDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDay', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByDueDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDay', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> sortByLast4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'last4', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      sortByLast4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'last4', Sort.desc);
    });
  }
}

extension CreditCardModelQuerySortThenBy
    on QueryBuilder<CreditCardModel, CreditCardModel, QSortThenBy> {
  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> thenByAlias() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alias', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByAliasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alias', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> thenByBank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bank', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByBankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bank', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByClosingDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'closingDay', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByClosingDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'closingDay', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByCreditLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimit', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByCreditLimitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditLimit', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> thenByDueDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDay', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByDueDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDay', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy> thenByLast4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'last4', Sort.asc);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QAfterSortBy>
      thenByLast4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'last4', Sort.desc);
    });
  }
}

extension CreditCardModelQueryWhereDistinct
    on QueryBuilder<CreditCardModel, CreditCardModel, QDistinct> {
  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct> distinctByAlias(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alias', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct> distinctByBank(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bank', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByClosingDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'closingDay');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct>
      distinctByCreditLimit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditLimit');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct> distinctByDueDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dueDay');
    });
  }

  QueryBuilder<CreditCardModel, CreditCardModel, QDistinct> distinctByLast4(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'last4', caseSensitive: caseSensitive);
    });
  }
}

extension CreditCardModelQueryProperty
    on QueryBuilder<CreditCardModel, CreditCardModel, QQueryProperty> {
  QueryBuilder<CreditCardModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CreditCardModel, String, QQueryOperations> aliasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alias');
    });
  }

  QueryBuilder<CreditCardModel, String, QQueryOperations> bankProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bank');
    });
  }

  QueryBuilder<CreditCardModel, int, QQueryOperations> closingDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'closingDay');
    });
  }

  QueryBuilder<CreditCardModel, double, QQueryOperations>
      creditLimitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditLimit');
    });
  }

  QueryBuilder<CreditCardModel, int, QQueryOperations> dueDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dueDay');
    });
  }

  QueryBuilder<CreditCardModel, String, QQueryOperations> last4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'last4');
    });
  }
}
