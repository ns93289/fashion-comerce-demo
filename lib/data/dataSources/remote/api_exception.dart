import 'package:dio/dio.dart';

class ApiException {
  Object getErrorMessage(Object exception) {
    if (exception is DioException) {
      return switch (exception.response?.statusCode ?? 0) {
        var code when code >= 200 && code <= 299 => 'Success',
        // var code when code >= 400 && code <= 499 => 'Client Error',
        var code when code >= 500 && code <= 599 => 'Internal Server Error',
        _ => 'Other',
      };
    } else {
      return exception;
    }
  }
}
