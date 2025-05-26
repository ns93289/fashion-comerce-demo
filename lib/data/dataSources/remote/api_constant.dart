class BaseUrl {
  static const String url = "http://192.168.1.5:8055/";
  static const String apiUrl = "$url/api";
}

class EndPoint {
  ///Movie APIs
  static const String register = "/register";
  static const String login = "/login";
  static const String logout = "/logout";

  ///Product list apis
  static const String productList = "/product-list";
  static const String popularPproductList = "/popular-product-list";
  static const String newProductList = "/new-product-list";
}

class ApiParams {
  static const String roleId = "role_id";
  static const String page = "page";
  static const String apiKey = "api_key";
  static const String language = "language";
  static const String email = "email";
  static const String name = "name";
  static const String phoneNumber = "phone_number";
  static const String userId = "user_id";
  static const String accessToken = "access_token";
  static const String password = "password";
}
