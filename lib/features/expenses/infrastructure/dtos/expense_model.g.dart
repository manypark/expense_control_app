// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetExpenseModelCollection on Isar {
  IsarCollection<ExpenseModel> get expenseModels => this.collection();
}

const ExpenseModelSchema = CollectionSchema(
  name: r'ExpenseModel',
  id: 8411865314220037745,
  properties: {
    r'amount': PropertySchema(id: 0, name: r'amount', type: IsarType.double),
    r'category': PropertySchema(
      id: 1,
      name: r'category',
      type: IsarType.string,
    ),
    r'creditCardId': PropertySchema(
      id: 2,
      name: r'creditCardId',
      type: IsarType.long,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'incurredAt': PropertySchema(
      id: 4,
      name: r'incurredAt',
      type: IsarType.dateTime,
    ),
    r'receiptPath': PropertySchema(
      id: 5,
      name: r'receiptPath',
      type: IsarType.string,
    ),
    r'statementMonth': PropertySchema(
      id: 6,
      name: r'statementMonth',
      type: IsarType.long,
    ),
    r'statementYear': PropertySchema(
      id: 7,
      name: r'statementYear',
      type: IsarType.long,
    ),
    r'title': PropertySchema(id: 8, name: r'title', type: IsarType.string),
  },
  estimateSize: _expenseModelEstimateSize,
  serialize: _expenseModelSerialize,
  deserialize: _expenseModelDeserialize,
  deserializeProp: _expenseModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'statementYear_statementMonth': IndexSchema(
      id: -3916231013503364020,
      name: r'statementYear_statementMonth',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'statementYear',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'statementMonth',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _expenseModelGetId,
  getLinks: _expenseModelGetLinks,
  attach: _expenseModelAttach,
  version: '3.1.0+1',
);

int _expenseModelEstimateSize(
  ExpenseModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.description.length * 3;
  {
    final value = object.receiptPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _expenseModelSerialize(
  ExpenseModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeString(offsets[1], object.category);
  writer.writeLong(offsets[2], object.creditCardId);
  writer.writeString(offsets[3], object.description);
  writer.writeDateTime(offsets[4], object.incurredAt);
  writer.writeString(offsets[5], object.receiptPath);
  writer.writeLong(offsets[6], object.statementMonth);
  writer.writeLong(offsets[7], object.statementYear);
  writer.writeString(offsets[8], object.title);
}

ExpenseModel _expenseModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExpenseModel();
  object.amount = reader.readDouble(offsets[0]);
  object.category = reader.readString(offsets[1]);
  object.creditCardId = reader.readLongOrNull(offsets[2]);
  object.description = reader.readString(offsets[3]);
  object.id = id;
  object.incurredAt = reader.readDateTime(offsets[4]);
  object.receiptPath = reader.readStringOrNull(offsets[5]);
  object.statementMonth = reader.readLong(offsets[6]);
  object.statementYear = reader.readLong(offsets[7]);
  object.title = reader.readString(offsets[8]);
  return object;
}

P _expenseModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _expenseModelGetId(ExpenseModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _expenseModelGetLinks(ExpenseModel object) {
  return [];
}

void _expenseModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  ExpenseModel object,
) {
  object.id = id;
}

extension ExpenseModelQueryWhereSort
    on QueryBuilder<ExpenseModel, ExpenseModel, QWhere> {
  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhere>
  anyStatementYearStatementMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'statementYear_statementMonth'),
      );
    });
  }
}

extension ExpenseModelQueryWhere
    on QueryBuilder<ExpenseModel, ExpenseModel, QWhereClause> {
  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause>
  statementYearEqualToAnyStatementMonth(int statementYear) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'statementYear_statementMonth',
          value: [statementYear],
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause>
  statementYearNotEqualToAnyStatementMonth(int statementYear) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'statementYear_statementMonth',
                lower: [],
                upper: [statementYear],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'statementYear_statementMonth',
                lower: [statementYear],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'statementYear_statementMonth',
                lower: [statementYear],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'statementYear_statementMonth',
                lower: [],
                upper: [statementYear],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause>
  statementYearGreaterThanAnyStatementMonth(
    int statementYear, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'statementYear_statementMonth',
          lower: [statementYear],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause>
  statementYearLessThanAnyStatementMonth(
    int statementYear, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'statementYear_statementMonth',
          lower: [],
          upper: [statementYear],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause>
  statementYearBetweenAnyStatementMonth(
    int lowerStatementYear,
    int upperStatementYear, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'statementYear_statementMonth',
          lower: [lowerStatementYear],
          includeLower: includeLower,
          upper: [upperStatementYear],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause>
  statementYearStatementMonthEqualTo(int statementYear, int statementMonth) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'statementYear_statementMonth',
          value: [statementYear, statementMonth],
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause>
  statementYearEqualToStatementMonthNotEqualTo(
    int statementYear,
    int statementMonth,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'statementYear_statementMonth',
                lower: [statementYear],
                upper: [statementYear, statementMonth],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'statementYear_statementMonth',
                lower: [statementYear, statementMonth],
                includeLower: false,
                upper: [statementYear],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'statementYear_statementMonth',
                lower: [statementYear, statementMonth],
                includeLower: false,
                upper: [statementYear],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'statementYear_statementMonth',
                lower: [statementYear],
                upper: [statementYear, statementMonth],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause>
  statementYearEqualToStatementMonthGreaterThan(
    int statementYear,
    int statementMonth, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'statementYear_statementMonth',
          lower: [statementYear, statementMonth],
          includeLower: include,
          upper: [statementYear],
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause>
  statementYearEqualToStatementMonthLessThan(
    int statementYear,
    int statementMonth, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'statementYear_statementMonth',
          lower: [statementYear],
          upper: [statementYear, statementMonth],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterWhereClause>
  statementYearEqualToStatementMonthBetween(
    int statementYear,
    int lowerStatementMonth,
    int upperStatementMonth, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'statementYear_statementMonth',
          lower: [statementYear, lowerStatementMonth],
          includeLower: includeLower,
          upper: [statementYear, upperStatementMonth],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ExpenseModelQueryFilter
    on QueryBuilder<ExpenseModel, ExpenseModel, QFilterCondition> {
  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition> amountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'amount',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  amountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'amount',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  amountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'amount',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition> amountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'amount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  categoryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'category',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  categoryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  categoryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'category',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'category', value: ''),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'category', value: ''),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  creditCardIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'creditCardId'),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  creditCardIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'creditCardId'),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  creditCardIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'creditCardId', value: value),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  creditCardIdGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'creditCardId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  creditCardIdLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'creditCardId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  creditCardIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'creditCardId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  descriptionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'description',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  descriptionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  descriptionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'description',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  incurredAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'incurredAt', value: value),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  incurredAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'incurredAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  incurredAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'incurredAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  incurredAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'incurredAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  receiptPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'receiptPath'),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  receiptPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'receiptPath'),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  receiptPathEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'receiptPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  receiptPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'receiptPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  receiptPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'receiptPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  receiptPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'receiptPath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  receiptPathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'receiptPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  receiptPathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'receiptPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  receiptPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'receiptPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  receiptPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'receiptPath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  receiptPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'receiptPath', value: ''),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  receiptPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'receiptPath', value: ''),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  statementMonthEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'statementMonth', value: value),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  statementMonthGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'statementMonth',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  statementMonthLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'statementMonth',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  statementMonthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'statementMonth',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  statementYearEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'statementYear', value: value),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  statementYearGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'statementYear',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  statementYearLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'statementYear',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  statementYearBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'statementYear',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition> titleContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition> titleMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterFilterCondition>
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }
}

extension ExpenseModelQueryObject
    on QueryBuilder<ExpenseModel, ExpenseModel, QFilterCondition> {}

extension ExpenseModelQueryLinks
    on QueryBuilder<ExpenseModel, ExpenseModel, QFilterCondition> {}

extension ExpenseModelQuerySortBy
    on QueryBuilder<ExpenseModel, ExpenseModel, QSortBy> {
  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> sortByCreditCardId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditCardId', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  sortByCreditCardIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditCardId', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> sortByIncurredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incurredAt', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  sortByIncurredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incurredAt', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> sortByReceiptPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiptPath', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  sortByReceiptPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiptPath', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  sortByStatementMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statementMonth', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  sortByStatementMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statementMonth', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> sortByStatementYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statementYear', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  sortByStatementYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statementYear', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension ExpenseModelQuerySortThenBy
    on QueryBuilder<ExpenseModel, ExpenseModel, QSortThenBy> {
  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> thenByCreditCardId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditCardId', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  thenByCreditCardIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creditCardId', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> thenByIncurredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incurredAt', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  thenByIncurredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'incurredAt', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> thenByReceiptPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiptPath', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  thenByReceiptPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiptPath', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  thenByStatementMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statementMonth', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  thenByStatementMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statementMonth', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> thenByStatementYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statementYear', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy>
  thenByStatementYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statementYear', Sort.desc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension ExpenseModelQueryWhereDistinct
    on QueryBuilder<ExpenseModel, ExpenseModel, QDistinct> {
  QueryBuilder<ExpenseModel, ExpenseModel, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QDistinct> distinctByCategory({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QDistinct> distinctByCreditCardId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creditCardId');
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QDistinct> distinctByDescription({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QDistinct> distinctByIncurredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'incurredAt');
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QDistinct> distinctByReceiptPath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'receiptPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QDistinct>
  distinctByStatementMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statementMonth');
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QDistinct>
  distinctByStatementYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statementYear');
    });
  }

  QueryBuilder<ExpenseModel, ExpenseModel, QDistinct> distinctByTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension ExpenseModelQueryProperty
    on QueryBuilder<ExpenseModel, ExpenseModel, QQueryProperty> {
  QueryBuilder<ExpenseModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ExpenseModel, double, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<ExpenseModel, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<ExpenseModel, int?, QQueryOperations> creditCardIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creditCardId');
    });
  }

  QueryBuilder<ExpenseModel, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<ExpenseModel, DateTime, QQueryOperations> incurredAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'incurredAt');
    });
  }

  QueryBuilder<ExpenseModel, String?, QQueryOperations> receiptPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'receiptPath');
    });
  }

  QueryBuilder<ExpenseModel, int, QQueryOperations> statementMonthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statementMonth');
    });
  }

  QueryBuilder<ExpenseModel, int, QQueryOperations> statementYearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statementYear');
    });
  }

  QueryBuilder<ExpenseModel, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
