import 'package:dio/dio.dart';

import '../../shared/models/either.dart';
import '../remote/api_base_helper.dart';
import '../remote/api_constant.dart';

///Repository class for movies
class MovieRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  dynamic getMovieList(int page) async {
    dynamic response = await _apiBaseHelper.get(
      api: EndPoint.movieList,
      queryParameters: {ApiParams.page: page, ApiParams.apiKey: "15b22726208b83af311f7513f00379d1", ApiParams.language: "en-US"},
    );

    return response;
  }

  dynamic getMovieDetails(int movieId) async {
    dynamic response = await _apiBaseHelper.get(
      api: "${EndPoint.movieDetails}/$movieId",
      queryParameters: {ApiParams.apiKey: "15b22726208b83af311f7513f00379d1", ApiParams.language: "en-US"},
    );

    return response;
  }
}

abstract class ApiRepository {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<Either<Object, Response>> post({required String api, Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async {
    return _apiBaseHelper.post(api: api, body: body, queryParameters: queryParameters);
  }

  Future<Either<Object, Response>> get({required String api, Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async {
    return _apiBaseHelper.get(api: api, queryParameters: queryParameters);
  }
}
