import 'package:dengue_tcc/app/utils/rest_client/rest_client_response.dart';

class RestClientException implements Exception {
  RestClientException({
    required this.error,
    required this.completeError,
    this.message,
    this.statusCode,
    this.response,
  });

  final String? message;
  final int? statusCode;
  final dynamic error;
  final dynamic completeError;
  final RestClientResponse? response;

  @override
  String toString() {
    return 'RestClientException(message: $message, statusCode: $statusCode, error: $error, response: $response, completeError: $completeError)';
  }

  RestClientException copyWith({
    String? message,
    int? statusCode,
    dynamic error,
    dynamic completeError,
    RestClientResponse? response,
    String? displayErrorMessage,
  }) {
    return RestClientException(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      error: error ?? this.error,
      completeError: completeError ?? this.completeError,
      response: response ?? this.response,
    );
  }
}
