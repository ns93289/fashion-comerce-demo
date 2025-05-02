class BaseUrl {
  static const String url = "https://api.themoviedb.org";
  static const String apiUrl = "$url/3";
}

class EndPoint {
  ///Movie APIs
  static const String movieList = "/trending/movie/day";
  static const String movieDetails = "/movie";
}

class ApiParams {
  static const String id = "id";
  static const String page = "page";
  static const String apiKey = "api_key";
  static const String language = "language";
}
