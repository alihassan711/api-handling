import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

class ApiError {
  static dynamic handleDioError(DioError dioError) {
    if (dioError.response != null) {
      final statusCode = dioError.response!.statusCode;

      if (statusCode == 400) {
        return {'error': 'Bad Request'};
      } else if (statusCode == 401) {
        return {'error': 'Unauthorized'};
      } else if (statusCode == 403) {
        return {'error': 'Forbidden'};
      } else if (statusCode == 404) {
        return {'error': 'Not Found'};
      } else if (statusCode == 429) {
        return {'error': 'Too Many Requests'};
      } else if (statusCode == 500) {
        return {'error': 'Internal Server Error'};
      } else {
        return {'error': 'Unexpected error: $statusCode'};
      }
    } else {
      if (dioError.error is SocketException) {
        return {'error': 'No internet connection'};
      } else if (dioError.error is TimeoutException) {
        return {'error': 'Request timeout'};
      } else {
        return {'error': dioError.message};
      }
    }
  }

  static dynamic handleError(dynamic error) {
    return {'error': error.toString()};
  }
}
