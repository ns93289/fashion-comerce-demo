import 'api_base_helper.dart';

abstract class ApiRepository {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<dynamic> post({required String api, Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async {
    return _apiBaseHelper.post(api: api, body: body, queryParameters: queryParameters);
  }

  Future<dynamic> get({required String api, Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async {
    return _apiBaseHelper.get(api: api, queryParameters: queryParameters);
  }
}
