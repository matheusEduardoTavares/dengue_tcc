import 'dart:io';

import 'package:dengue_tcc/app/modules/core/repositories/auth_repository/auth_repository.dart';
import 'package:dengue_tcc/app/modules/core/repositories/auth_repository/auth_repository_impl.dart';
import 'package:dengue_tcc/app/modules/core/repositories/local_repository/local_repository.dart';
import 'package:dengue_tcc/app/utils/environment/environment.dart';
import 'package:dengue_tcc/app/utils/environment/environment_keys.dart';
import 'package:dengue_tcc/app/utils/rest_client/api_definitions/api_definitions.dart';
import 'package:dengue_tcc/app/utils/rest_client/interceptors/auth_interceptor.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client_exception.dart';
import 'package:dengue_tcc/app/utils/rest_client/rest_client_response.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class DioRestClient implements RestClient {
  DioRestClient({
    required LocalRepository localRepository,
    required Environment environment,
    AuthRepository? authRepository,
    bool? useHttpsSecurityProtocol,
    BaseOptions? options,
  }) {
    _baseURL = environment.getVariable(
      EnvironmentKeys.apiURL,
    )!;
    _dio = Dio(options ?? _getOptions());

    // ignore: no_leading_underscores_for_local_identifiers
    final _authRepository = authRepository ??
        AuthRepositoryImpl(
          client: this,
        );

    if (useHttpsSecurityProtocol ?? true) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return null;
      };
    }

    _dio.interceptors.addAll([
      AuthInterceptor(
        localRepository: localRepository,
        restClient: this,
        authRepository: _authRepository,
      ),
    ]);

    _getOptions();
  }

  late String _baseURL;
  late Dio _dio;
  static BaseOptions? _options;

  BaseOptions _getOptions() {
    return _options ??= BaseOptions(
      baseUrl: ApiDefinitions.getBaseUrl(
        url: _baseURL,
      ),
      contentType: 'application/json',
    );
  }

  @override
  RestClient auth() {
    _options!.extra['auth_required'] = true;
    return this;
  }

  @override
  RestClient unauth() {
    _options!.extra['auth_required'] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> post<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: _getErrorMessage(e.response),
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
        completeError: e,
      );
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: _getErrorMessage(e.response),
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
        completeError: e,
      );
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: _getErrorMessage(e.response),
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
        completeError: e,
      );
    }
  }

  @override
  Future<RestClientResponse<T>> delete<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: _getErrorMessage(e.response),
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
        completeError: e,
      );
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: _getErrorMessage(e.response),
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
        completeError: e,
      );
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(String path,
      {required String method,
      data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? extra}) async {
    try {
      final response = await _dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          method: method,
          extra: extra,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: _getErrorMessage(e.response),
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
        completeError: e,
      );
    }
  }

  @override
  Future<RestClientResponse> download(String path,
      {required dynamic savePath,
      data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.download(
        path,
        savePath,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioError catch (e) {
      throw RestClientException(
        error: e.error,
        message: _getErrorMessage(e.response),
        statusCode: e.response?.statusCode,
        response: _dioErrorConverter(e.response),
        completeError: e,
      );
    }
  }

  RestClientResponse<T> _dioErrorConverter<T>(Response? response) {
    return RestClientResponse<T>(
      data: response?.data,
      statusCode: response?.statusCode,
      statusMessage: response?.statusMessage,
    );
  }

  String? _getErrorMessage(Response? response) {
    final responseMap = response?.data;
    String? apiResponseErrorMessage;
    if (responseMap is Map) {
      apiResponseErrorMessage = responseMap['detail'];
    }

    return apiResponseErrorMessage ?? response?.statusMessage;
  }
}
