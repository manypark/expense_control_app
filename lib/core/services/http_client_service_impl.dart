import 'package:dio/dio.dart';

import 'auth_storage_service.dart';
import 'http_client_interceptor.dart';
import 'http_client_service.dart';

class HttpClientServiceImpl extends HttpClientService {
  HttpClientServiceImpl({
    required String baseUrl,
    AuthStorageService? authStorage,
  }) : _authStorage = authStorage ?? AuthStorageService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2),
        responseType: ResponseType.json,
      ),
    );

    _dio.interceptors.add(
      HttpClientInterceptor(baseUrl: baseUrl, authStorage: _authStorage),
    );
  }

  final AuthStorageService _authStorage;
  late final Dio _dio;

  @override
  Future<dynamic> delete({required String path, Options? options}) async {
    final response = await _dio.delete<dynamic>(path, options: options);
    return response.data;
  }

  @override
  Future<dynamic> get({required String path, Options? options}) async {
    final response = await _dio.get<dynamic>(path, options: options);
    return response.data;
  }

  @override
  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    final response = await _dio.post<dynamic>(
      path,
      data: data,
      options: options,
    );
    return response.data;
  }

  @override
  Future<dynamic> put({
    required String path,
    required Map<String, dynamic> data,
    Options? options,
  }) async {
    final response = await _dio.put<dynamic>(
      path,
      data: data,
      options: options,
    );
    return response.data;
  }

  @override
  Future<dynamic> postWithoutAuth({
    required String path,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    final response = await _dio.post<dynamic>(
      path,
      data: data,
      options:
          options ??
          Options(headers: {'Content-Type': 'application/json; charset=utf-8'}),
    );
    return response.data;
  }
}
