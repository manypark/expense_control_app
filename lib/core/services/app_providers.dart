import 'dart:async';

import 'package:expense_control_app/features/cards/domain/domain.dart';
import 'package:expense_control_app/features/dashboard/domain/domain.dart';
import 'package:expense_control_app/features/expenses/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_storage_service.dart';
import 'http_client_service.dart';
import 'http_client_service_impl.dart';

part 'app_providers.g.dart';

class AuthSession {
  const AuthSession({
    required this.token,
    required this.refreshToken,
    required this.userId,
    required this.email,
  });

  final String token;
  final String refreshToken;
  final String userId;
  final String email;
}

@Riverpod(keepAlive: true)
String apiBaseUrl(ApiBaseUrlRef ref) {
  return const String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000',
  );
}

@Riverpod(keepAlive: true)
HttpClientService apiClient(ApiClientRef ref) {
  final baseUrl = ref.watch(apiBaseUrlProvider);
  return HttpClientServiceImpl(baseUrl: baseUrl);
}

@riverpod
class AuthController extends _$AuthController {
  final _storage = AuthStorageService();

  @override
  FutureOr<AuthSession?> build() async {
    final session = await _storage.readSession();
    final token = session[AuthStorageService.tokenKey];
    final refreshToken = session[AuthStorageService.refreshTokenKey];
    final email = session[AuthStorageService.emailKey];
    final userId = session[AuthStorageService.userIdKey];

    if (token == null ||
        refreshToken == null ||
        email == null ||
        userId == null) {
      return null;
    }

    return AuthSession(
      token: token,
      refreshToken: refreshToken,
      userId: userId,
      email: email,
    );
  }

  Future<void> register(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiClientProvider);
      final json =
          await api.postWithoutAuth(
                path: '/auth/register',
                data: {'email': email, 'password': password},
              )
              as Map<String, dynamic>;
      return _persistSession(json);
    });
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiClientProvider);
      final json =
          await api.postWithoutAuth(
                path: '/auth/login',
                data: {'email': email, 'password': password},
              )
              as Map<String, dynamic>;
      return _persistSession(json);
    });
  }

  Future<void> logout() async {
    await _storage.clear();
    state = const AsyncData(null);
    ref.invalidate(accountsStreamProvider);
    ref.invalidate(cardsStreamProvider);
    ref.invalidate(expensesStreamProvider);
  }

  Future<AuthSession> _persistSession(Map<String, dynamic> json) async {
    final token = json['accessToken'] as String?;
    final refreshToken = json['refreshToken'] as String?;
    final user = json['user'] as Map<String, dynamic>?;
    final userId = user?['id'] as String?;
    final email = user?['email'] as String?;

    if (token == null ||
        refreshToken == null ||
        userId == null ||
        email == null) {
      throw Exception('Respuesta de autenticacion invalida');
    }

    final session = AuthSession(
      token: token,
      refreshToken: refreshToken,
      userId: userId,
      email: email,
    );

    await _storage.saveSession(
      accessToken: session.token,
      refreshToken: session.refreshToken,
      userId: session.userId,
      email: session.email,
    );

    ref.invalidate(accountsStreamProvider);
    ref.invalidate(cardsStreamProvider);
    ref.invalidate(expensesStreamProvider);

    return session;
  }
}

MoneyAccountEntity _accountFromJson(Map<String, dynamic> json) {
  return MoneyAccountEntity(
    id: json['id'] as String,
    code: json['code'] as String,
    name: json['name'] as String,
    balance: (json['balance'] as num).toDouble(),
  );
}

CreditCardEntity _cardFromJson(Map<String, dynamic> json) {
  return CreditCardEntity(
    id: json['id'] as String,
    alias: json['alias'] as String,
    bank: json['bank'] as String,
    last4: json['last4'] as String,
    closingDay: json['closingDay'] as int,
    dueDay: json['dueDay'] as int,
    creditLimit: (json['creditLimit'] as num).toDouble(),
  );
}

ExpenseEntity _expenseFromJson(Map<String, dynamic> json) {
  return ExpenseEntity(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
    amount: (json['amount'] as num).toDouble(),
    incurredAt: DateTime.parse(json['incurredAt'] as String),
    creditCardId: json['creditCardId'] as String?,
    statementYear: json['statementYear'] as int,
    statementMonth: json['statementMonth'] as int,
  );
}

@riverpod
Future<List<MoneyAccountEntity>> accountsStream(AccountsStreamRef ref) async {
  final api = ref.read(apiClientProvider);
  final list = await api.get(path: '/accounts') as List<dynamic>;
  return list
      .map((item) => _accountFromJson(item as Map<String, dynamic>))
      .toList(growable: false);
}

@riverpod
class AccountCommands extends _$AccountCommands {
  @override
  void build() {}

  Future<void> upsertAccount(MoneyAccountEntity account) async {
    final api = ref.read(apiClientProvider);

    final body = {
      'code': account.code,
      'name': account.name,
      'balance': account.balance,
    };

    if (account.id.isEmpty) {
      await api.post(path: '/accounts', data: body);
    } else {
      await api.put(path: '/accounts/${account.id}', data: body);
    }

    ref.invalidate(accountsStreamProvider);
  }

  Future<void> deleteAccount(String accountId) async {
    final api = ref.read(apiClientProvider);
    await api.delete(path: '/accounts/$accountId');
    ref.invalidate(accountsStreamProvider);
  }
}

@riverpod
Future<List<CreditCardEntity>> cardsStream(CardsStreamRef ref) async {
  final api = ref.read(apiClientProvider);
  final list = await api.get(path: '/cards') as List<dynamic>;
  return list
      .map((item) => _cardFromJson(item as Map<String, dynamic>))
      .toList(growable: false);
}

@riverpod
class CardCommands extends _$CardCommands {
  @override
  void build() {}

  Future<void> saveCard(CreditCardEntity card) async {
    final api = ref.read(apiClientProvider);

    final body = {
      'alias': card.alias,
      'bank': card.bank,
      'last4': card.last4,
      'closingDay': card.closingDay,
      'dueDay': card.dueDay,
      'creditLimit': card.creditLimit,
    };

    if (card.id.isEmpty) {
      await api.post(path: '/cards', data: body);
    } else {
      await api.put(path: '/cards/${card.id}', data: body);
    }

    ref.invalidate(cardsStreamProvider);
  }
}

@riverpod
Future<List<ExpenseEntity>> expensesStream(ExpensesStreamRef ref) async {
  final api = ref.read(apiClientProvider);
  final list = await api.get(path: '/expenses') as List<dynamic>;
  return list
      .map((item) => _expenseFromJson(item as Map<String, dynamic>))
      .toList(growable: false);
}

@riverpod
class ExpenseCommands extends _$ExpenseCommands {
  @override
  void build() {}

  Future<void> saveExpense(ExpenseEntity expense) async {
    final api = ref.read(apiClientProvider);

    final body = {
      'title': expense.title,
      'description': expense.description,
      'category': expense.category,
      'amount': expense.amount,
      'incurredAt': expense.incurredAt.toUtc().toIso8601String(),
      'statementYear': expense.statementYear,
      'statementMonth': expense.statementMonth,
      'creditCardId': expense.creditCardId,
    };

    if (expense.id.isEmpty) {
      await api.post(path: '/expenses', data: body);
    } else {
      await api.put(path: '/expenses/${expense.id}', data: body);
    }

    ref.invalidate(expensesStreamProvider);
  }
}
