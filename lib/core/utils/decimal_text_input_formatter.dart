import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  final int maxDigits;
  final int decimalRange;

  DecimalTextInputFormatter({this.maxDigits = 8, this.decimalRange = 2}) : assert(decimalRange >= 0);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Allow empty input
    if (newText.isEmpty) {
      return newValue;
    }

    // Only digits and optionally one decimal point
    final regex = RegExp(r'^\d*\.?\d*$');
    if (!regex.hasMatch(newText)) {
      return oldValue;
    }

    // Split into integer and decimal parts
    List<String> parts = newText.split('.');
    String intPart = parts[0];

    // Check max length: total digits including decimals should not exceed maxDigits
    int totalDigits = intPart.length + (parts.length > 1 ? parts[1].length : 0);
    if (totalDigits > maxDigits) {
      return oldValue;
    }

    // Check decimal precision
    if (parts.length > 1 && parts[1].length > decimalRange) {
      return oldValue;
    }

    return newValue;
  }
}
