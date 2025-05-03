import '../../network/api_constant.dart';
import '../../network/api_repository.dart';

class MovieRepository extends ApiRepository {
  Future<dynamic> getMovieList(int page) async {
    dynamic response = await get(
      api: EndPoint.movieList,
      queryParameters: {ApiParams.page: page, ApiParams.apiKey: "15b22726208b83af311f7513f00379d1", ApiParams.language: "en-US"},
    );

    return response;
  }

  Future<dynamic> getMovieDetails(int movieId) async {
    dynamic response = await get(
      api: "${EndPoint.movieDetails}/$movieId",
      queryParameters: {ApiParams.apiKey: "15b22726208b83af311f7513f00379d1", ApiParams.language: "en-US"},
    );

    return response;
  }
}
