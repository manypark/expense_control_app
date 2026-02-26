import 'dart:async';
import 'dart:convert';

import 'package:expense_control_app/features/cards/domain/domain.dart';
import 'package:expense_control_app/features/dashboard/domain/domain.dart';
import 'package:expense_control_app/features/expenses/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_providers.g.dart';

class AuthSession {
  const AuthSession({
    required this.token,
    required this.userId,
    required this.email,
  });

  final String token;
  final String userId;
  final String email;
}

class ApiClient {
  const ApiClient({required this.baseUrl});

  final String baseUrl;

  Future<dynamic> get(String path, {String? token}) async {
    final response = await http.get(
      Uri.parse('$baseUrl$path'),
      headers: _headers(token: token),
    );
    return _decode(response);
  }

  Future<dynamic> post(
    String path,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: _headers(token: token),
      body: jsonEncode(body),
    );
    return _decode(response);
  }

  Future<dynamic> patch(
    String path,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final response = await http.patch(
      Uri.parse('$baseUrl$path'),
      headers: _headers(token: token),
      body: jsonEncode(body),
    );
    return _decode(response);
  }

  Future<dynamic> delete(String path, {String? token}) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$path'),
      headers: _headers(token: token),
    );
    return _decode(response);
  }

  Map<String, String> _headers({String? token}) {
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  dynamic _decode(http.Response response) {
    final body = response.body.isEmpty ? null : jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }
    throw Exception('HTTP ${response.statusCode}: ${response.body}');
  }
}

@Riverpod(keepAlive: true)
String apiBaseUrl(ApiBaseUrlRef ref) {
  return const String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000',
  );
}

@Riverpod(keepAlive: true)
ApiClient apiClient(ApiClientRef ref) {
  final baseUrl = ref.watch(apiBaseUrlProvider);
  return ApiClient(baseUrl: baseUrl);
}

@riverpod
class AuthController extends _$AuthController {
  static const _tokenKey = 'auth_token';
  static const _emailKey = 'auth_email';
  static const _userIdKey = 'auth_user_id';

  @override
  FutureOr<AuthSession?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final email = prefs.getString(_emailKey);
    final userId = prefs.getString(_userIdKey);

    if (token == null || email == null || userId == null) return null;

    return AuthSession(token: token, userId: userId, email: email);
  }

  Future<void> register(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiClientProvider);
      final json =
          await api.post('/auth/register', {
                'email': email,
                'password': password,
              })
              as Map<String, dynamic>;
      return _persistSession(json);
    });
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiClientProvider);
      final json =
          await api.post('/auth/login', {'email': email, 'password': password})
              as Map<String, dynamic>;
      return _persistSession(json);
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_userIdKey);
    state = const AsyncData(null);
    ref.invalidate(accountsStreamProvider);
    ref.invalidate(cardsStreamProvider);
    ref.invalidate(expensesStreamProvider);
  }

  Future<AuthSession> _persistSession(Map<String, dynamic> json) async {
    final token = json['accessToken'] as String;
    final user = json['user'] as Map<String, dynamic>;
    final session = AuthSession(
      token: token,
      userId: user['id'] as String,
      email: user['email'] as String,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, session.token);
    await prefs.setString(_emailKey, session.email);
    await prefs.setString(_userIdKey, session.userId);

    ref.invalidate(accountsStreamProvider);
    ref.invalidate(cardsStreamProvider);
    ref.invalidate(expensesStreamProvider);

    return session;
  }
}

String _requireToken(Ref ref) {
  final session = ref.read(authControllerProvider).valueOrNull;
  if (session == null) throw Exception('No hay sesion activa');
  return session.token;
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
  final token = _requireToken(ref);
  final api = ref.read(apiClientProvider);
  final list = await api.get('/accounts', token: token) as List<dynamic>;
  return list
      .map((item) => _accountFromJson(item as Map<String, dynamic>))
      .toList(growable: false);
}

@riverpod
class AccountCommands extends _$AccountCommands {
  @override
  void build() {}

  Future<void> upsertAccount(MoneyAccountEntity account) async {
    final token = _requireToken(ref);
    final api = ref.read(apiClientProvider);

    final body = {
      'code': account.code,
      'name': account.name,
      'balance': account.balance,
    };

    if (account.id.isEmpty) {
      await api.post('/accounts', body, token: token);
    } else {
      await api.patch('/accounts/${account.id}', body, token: token);
    }

    ref.invalidate(accountsStreamProvider);
  }

  Future<void> deleteAccount(String accountId) async {
    final token = _requireToken(ref);
    final api = ref.read(apiClientProvider);
    await api.delete('/accounts/$accountId', token: token);
    ref.invalidate(accountsStreamProvider);
  }
}

@riverpod
Future<List<CreditCardEntity>> cardsStream(CardsStreamRef ref) async {
  final token = _requireToken(ref);
  final api = ref.read(apiClientProvider);
  final list = await api.get('/cards', token: token) as List<dynamic>;
  return list
      .map((item) => _cardFromJson(item as Map<String, dynamic>))
      .toList(growable: false);
}

@riverpod
class CardCommands extends _$CardCommands {
  @override
  void build() {}

  Future<void> saveCard(CreditCardEntity card) async {
    final token = _requireToken(ref);
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
      await api.post('/cards', body, token: token);
    } else {
      await api.patch('/cards/${card.id}', body, token: token);
    }

    ref.invalidate(cardsStreamProvider);
  }
}

@riverpod
Future<List<ExpenseEntity>> expensesStream(ExpensesStreamRef ref) async {
  final token = _requireToken(ref);
  final api = ref.read(apiClientProvider);
  final list = await api.get('/expenses', token: token) as List<dynamic>;
  return list
      .map((item) => _expenseFromJson(item as Map<String, dynamic>))
      .toList(growable: false);
}

@riverpod
class ExpenseCommands extends _$ExpenseCommands {
  @override
  void build() {}

  Future<void> saveExpense(ExpenseEntity expense) async {
    final token = _requireToken(ref);
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
      await api.post('/expenses', body, token: token);
    } else {
      await api.patch('/expenses/${expense.id}', body, token: token);
    }

    ref.invalidate(expensesStreamProvider);
  }
}
