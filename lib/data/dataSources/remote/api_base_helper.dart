import 'package:dio/dio.dart';
import 'package:fashion_comerce_demo/core/utils/tools.dart';

import '../local/hive_constants.dart';
import '../local/hive_helper.dart';
import 'api_constant.dart';
import 'api_exception.dart';

class ApiBaseHelper {
  final _dio = Dio();

  ApiBaseHelper({String? baseUrl}) {
    _dio.options.baseUrl = baseUrl ?? BaseUrl.apiUrl;
    _dio.options.receiveTimeout = Duration(seconds: 3);
    _dio.options.connectTimeout = Duration(seconds: 3);
    String accessToken = getStringDataFromUserBox(key: hiveAccessToken);
    if (accessToken.isNotEmpty) {
      _dio.options.headers = {'authorization': "Bearer $accessToken"};
    }
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

  Future<dynamic> put({required String api, Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async {
    Response response = await _dio.put(api, data: body, queryParameters: queryParameters);
    try {
      logD("post>>>", response.data.toString());
      return response.data;
    } catch (e) {
      throw ApiException().getErrorMessage(e);
    }
  }

  dynamic putForm({required String api, FormData? body, Map<String, dynamic>? queryParameters}) async {
    Response response = await _dio.put(api, data: body, queryParameters: queryParameters);
    try {
      return response.data;
    } catch (e) {
      throw ApiException().getErrorMessage(e);
    }
  }

  dynamic get({required String api, Map<String, dynamic>? queryParameters, Map<String, dynamic>? body}) async {
    Response response = await _dio.get(api, queryParameters: queryParameters, data: body);
    try {
      return response.data;
    } catch (e) {
      throw ApiException().getErrorMessage(e);
    }
  }
}
