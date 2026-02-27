import 'dart:async';

import 'package:dio/dio.dart';

import 'auth_storage_service.dart';

class HttpClientInterceptor extends Interceptor {
  HttpClientInterceptor({required this.baseUrl, required this.authStorage});

  final String baseUrl;
  final AuthStorageService authStorage;
  Future<String?>? _refreshFuture;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isAuthPath(options.path)) {
      return handler.next(options);
    }

    final token = await authStorage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final requestOptions = err.requestOptions;
    final alreadyRetried = requestOptions.extra['retried'] == true;

    if (statusCode == 401 &&
        !_isAuthPath(requestOptions.path) &&
        !alreadyRetried) {
      final refreshedToken = await _refreshAccessToken();
      if (refreshedToken == null) {
        await authStorage.clear();
        return handler.next(err);
      }

      try {
        final retryDio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(minutes: 2),
            receiveTimeout: const Duration(minutes: 2),
            responseType: ResponseType.json,
          ),
        );

        final retryOptions = requestOptions.copyWith(
          headers: {
            ...requestOptions.headers,
            'Authorization': 'Bearer $refreshedToken',
          },
          extra: {...requestOptions.extra, 'retried': true},
        );

        final response = await retryDio.fetch<dynamic>(retryOptions);
        return handler.resolve(response);
      } catch (retryError) {
        return handler.next(err);
      }
    }

    handler.next(err);
  }

  bool _isAuthPath(String path) {
    final normalizedPath = path.startsWith('http')
        ? (Uri.tryParse(path)?.path ?? path)
        : path;

    return normalizedPath == '/auth/login' ||
        normalizedPath == '/auth/register' ||
        normalizedPath == '/auth/refresh';
  }

  Future<String?> _refreshAccessToken() async {
    if (_refreshFuture != null) {
      return _refreshFuture;
    }

    _refreshFuture = _performRefreshToken();
    final token = await _refreshFuture;
    _refreshFuture = null;
    return token;
  }

  Future<String?> _performRefreshToken() async {
    final session = await authStorage.readSession();
    final refreshToken = session[AuthStorageService.refreshTokenKey];
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2),
        responseType: ResponseType.json,
      ),
    );

    try {
      final response = await dio.post<dynamic>(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      final data = response.data as Map<String, dynamic>;
      final accessToken = data['accessToken'] as String?;
      final nextRefreshToken =
          (data['refreshToken'] as String?) ?? refreshToken;
      final user = data['user'] as Map<String, dynamic>?;
      final userId =
          (user?['id'] as String?) ?? session[AuthStorageService.userIdKey];
      final email =
          (user?['email'] as String?) ?? session[AuthStorageService.emailKey];

      if (accessToken == null || userId == null || email == null) {
        return null;
      }

      await authStorage.saveSession(
        accessToken: accessToken,
        refreshToken: nextRefreshToken,
        userId: userId,
        email: email,
      );

      return accessToken;
    } catch (_) {
      return null;
    }
  }
}
