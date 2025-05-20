class BaseUrl {
  static const String url = "https://api.themoviedb.org";
  static const String apiUrl = "$url/3";
}

class EndPoint {
  ///Movie APIs
  static const String movieList = "/trending/movie/day";
  static const String movieDetails = "/movie";

  ///Product list apis
  static const String productList = "/product-list";
  static const String popularPproductList = "/popular-product-list";
  static const String newProductList = "/new-product-list";
}

class ApiParams {
  static const String id = "id";
  static const String page = "page";
  static const String apiKey = "api_key";
  static const String language = "language";
  static const String email = "email";
  static const String userId = "user_id";
  static const String accessToken = "access_token";
  static const String password = "password";
}
