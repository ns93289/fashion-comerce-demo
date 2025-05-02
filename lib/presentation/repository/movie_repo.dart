import 'package:dio/dio.dart';

import '../../data/remote/api_constant.dart';
import '../../data/repository/api_repository.dart';
import '../../shared/models/either.dart';

class MovieRepository extends ApiRepository {
  Future<Either<Object, Response>> getMovieList(int page) async {
    dynamic response = await get(
      api: EndPoint.movieList,
      queryParameters: {ApiParams.page: page, ApiParams.apiKey: "15b22726208b83af311f7513f00379d1", ApiParams.language: "en-US"},
    );

    return response;
  }

  Future<Either<Object, Response>> getMovieDetails(int movieId) async {
    dynamic response = await get(
      api: "${EndPoint.movieDetails}/$movieId",
      queryParameters: {ApiParams.apiKey: "15b22726208b83af311f7513f00379d1", ApiParams.language: "en-US"},
    );

    return response;
  }
}
