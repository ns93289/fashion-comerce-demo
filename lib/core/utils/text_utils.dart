import '../../domain/entities/address_entity.dart';
import '../constants/extensions.dart';

class TextUtils {
  static String maskEmailUsername(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 4) {
      return '${'*' * username.length}@$domain';
    }

    final firstTwo = username.substring(0, 2);
    final lastTwo = username.substring(username.length - 2);
    final masked = '*' * (username.length - 4);

    return '$firstTwo$masked$lastTwo@$domain';
  }

  static String maskMobileNumber(String phone) {
    if (phone.length <= 4) return '*' * phone.length;

    String firstTwo = phone.substring(0, 2);
    String lastTwo = phone.substring(phone.length - 2);
    String masked = '*' * (phone.length - 4);

    return '$firstTwo$masked$lastTwo';
  }

  static String getDiscountString(int discountType, num discountValue) {
    return discountType == 1 ? "$discountValue%" : discountValue.withCurrency;
  }

  static String getFullAddress(AddressEntity address) {
    final AddressEntity(:houseName, :houseNo, :street, :addressLine1, :addressLine2, :city, :state, :pinCode) = address;
    String fullAddress = houseName;
    if (houseNo.isNotEmpty) fullAddress += ",$houseNo";
    if (street.isNotEmpty) fullAddress += ",$street";
    if (addressLine1.isNotEmpty) fullAddress += ",$addressLine1";
    if (addressLine2.isNotEmpty) fullAddress += ",$addressLine2";
    if (city.isNotEmpty) fullAddress += ",$city";
    if (state.isNotEmpty) fullAddress += ",$state";
    if (pinCode.isNotEmpty) fullAddress += ",$pinCode";

    return fullAddress;
  }
}
