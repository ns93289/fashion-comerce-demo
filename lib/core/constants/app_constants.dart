sealed class PaymentType {
  static const int wallet = 1;
  static const int card = 2;
  static const int cash = 3;
}

sealed class LanguageCodes {
  static const String english = "en";
  static const String spanish = "es";
}

sealed class AddressTypes {
  static const int home = 1;
  static const int work = 2;
  static const int other = 3;
}
