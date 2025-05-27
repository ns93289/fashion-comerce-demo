class BaseUrl {
  static const String url = "http://192.168.1.6:8055/";
  static const String apiUrl = "$url/api";
}

class EndPoint {
  ///Authentication APIs...
  static const String register = "/register";
  static const String login = "/login";
  static const String logout = "/logout";
  static const String emailVerification = "/email-verification";
  static const String mobileVerification = "/mobile-verification";

  ///User Profile APIs...
  static const String updateProfile = "/users/update";

  ///Product list apis
  static const String productList = "/product-list";
  static const String popularProductList = "/popular-product-list";
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
  static const String code = "code";
  static const String profilePicture = "profile_picture";
}
