sealed class PaymentType {
  static const int wallet = 1;
  static const int card = 2;
  static const int cash = 3;
  static const int googlePay = 4;
  static const int amazonPay = 5;
  static const int payPal = 6;
}

sealed class LanguageCodes {
  static const String english = "en";
  static const String spanish = "es";
}

sealed class AddressTypes {
  static const int home = 1;
  static const int work = 2;
  static const int other = 3;
  static const int family = 4;
}

sealed class GenderTypes {
  static const int all = 0;
  static const int male = 1;
  static const int female = 2;
  static const int kids = 3;
}

sealed class DeliveryTypes {
  static const int fast = 1;
  static const int express = 2;
  static const int standard = 3;
}

sealed class DefaultData {
  static const String countryCodeName = "US";
  static const int pageSize = 10;
  static const bool localMode = false;
}
