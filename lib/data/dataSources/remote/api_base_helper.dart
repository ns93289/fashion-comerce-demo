import 'package:dio/dio.dart';
import 'package:fashion_comerce_demo/core/utils/tools.dart';

import 'api_constant.dart';
import 'api_exception.dart';

class ApiBaseHelper {
  final _dio = Dio();

  ApiBaseHelper({String? baseUrl}) {
    _dio.options.baseUrl = baseUrl ?? BaseUrl.apiUrl;
    _dio.options.receiveTimeout = Duration(seconds: 3);
    _dio.options.connectTimeout = Duration(seconds: 3);
    _dio.interceptors.add(LogInterceptor(request: true, responseBody: true, requestHeader: true, requestBody: true, error: true));
  }

  Future<dynamic> post({required String api, Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async {
    Response response = await _dio.post(api, data: body, queryParameters: queryParameters);
    try {
      logD("post>>>", response.data.toString());
      return response.data;
    } catch (e) {
      throw ApiException().getErrorMessage(e);
    }
  }

  dynamic postForm({required String api, FormData? body, Map<String, dynamic>? queryParameters}) async {
    Response response = await _dio.post(api, data: body, queryParameters: queryParameters);
    try {
      return response.data;
    } catch (e) {
      throw ApiException().getErrorMessage(e);
    }
  }

  dynamic get({required String api, Map<String, dynamic>? queryParameters}) async {
    Response response = await _dio.get(api, queryParameters: queryParameters);
    try {
      return response.data;
    } catch (e) {
      throw ApiException().getErrorMessage(e);
    }
  }
}
