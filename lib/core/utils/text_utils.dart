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
}
