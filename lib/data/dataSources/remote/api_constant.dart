class BaseUrl {
  static const String url = "http://192.168.1.5:8055/";
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
  static const String changePassword = "/users/change-password";

  ///Categories APIs...
  static const String getCategories = "/category/get";
  static const String getSubCategories = "/sub-category/get";

  ///Product list apis
  static const String productList = "/product-list";
  static const String popularProductList = "/popular-product-list";
  static const String newProductList = "/new-product-list";

  ///Address Apis...
  static const String addAddress = "/address/add";
  static const String editAddress = "/address/update";
  static const String getAddress = "/address/get";
  static const String deleteAddress = "/address/delete";
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
  static const String genderId = "gender_id";
  static const String categoryId = "category_id";
  static const String currentPassword = "current_password";
  static const String newPassword = "new_password";
  static const String addressTypeId = "address_type_id";
  static const String houseName = "house_name";
  static const String houseNumber = "house_number";
  static const String street = "street";
  static const String line1 = "line1";
  static const String line2 = "line2";
  static const String city = "city";
  static const String state = "state";
  static const String postalCode = "postal_code";
  static const String country = "country";
}
