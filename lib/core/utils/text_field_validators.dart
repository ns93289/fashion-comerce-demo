import 'package:fashion_comerce_demo/main.dart';

class TextFieldValidator {
  static String? emptyValidator(String value, {String? message}) {
    if (value.isEmpty) {
      return message;
    }
    return null;
  }

  static String? passwordValidator({required String password, String? message}) {
    if (password.isEmpty) {
      return message ?? language.enterPassword;
    } else if (password.length < 6) {
      return language.minPassLength;
    }
    return null;
  }

  static String? otpValidator({required String otp}) {
    if (otp.isEmpty) {
      return language.enterOTP;
    } else if (otp.length < 6) {
      return language.enterFullOTP;
    }
    return null;
  }

  static String? passwordMatchValidator({required String password, required String confirmPassword}) {
    if (confirmPassword.isEmpty) {
      return language.enterConfirmPassword;
    } else if (password != confirmPassword) {
      return language.confirmPassMatch;
    }
    return null;
  }

  static String? emailValidator(String email) {
    if (email.isEmpty) {
      return language.enterEmail;
    } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return language.invalidEmail;
    }
    return null;
  }
}
