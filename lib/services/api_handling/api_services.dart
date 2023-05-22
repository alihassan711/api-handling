import 'package:api_exception/services/exception_handling/api_exceptions.dart';
import 'package:dio/dio.dart';

enum HttpMethod {
  GET,
  POST,
  PUT,
  DELETE,
}

class ApiService {
  late Dio _dio;

  ApiService() {
    _dio = Dio(); // Initialize Dio instance
  }

  Future<dynamic> makeApiCall(String url, HttpMethod method,
      {dynamic data, Map<String, dynamic>? headers}) async {
    // If headers are null, initialize them as a default header
    headers ??= {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    late Response response;

    try {
      switch (method) {
        case HttpMethod.GET:
          response = await _dio.get(url, options: Options(headers: headers));
          break;
        case HttpMethod.POST:
          response = await _dio.post(
            url,
            data: data,
            options: Options(headers: headers),
          );
          break;
        case HttpMethod.PUT:
          response = await _dio.put(
            url,
            data: data,
            options: Options(headers: headers),
          );
          break;
        case HttpMethod.DELETE:
          response = await _dio.delete(
            url,
            options: Options(headers: headers),
          );
          break;
      }

      if (response.statusCode == 200) {
        return response.data;
      } else {
        final requestOptions = response.requestOptions;
        return ApiError.handleDioError(DioError(
          response: response,
          requestOptions: requestOptions,
          error: 'API Error ${response.statusCode}',
        ));
      }
    } catch (error) {
      if (error is DioError) {
        return ApiError.handleDioError(error);
      } else {
        return ApiError.handleError(error);
      }
    }
  }
}
