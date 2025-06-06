import 'package:flutter/material.dart';

extension IndexedIterable<T> on Iterable<T> {
  Iterable<R> mapIndexed<R>(R Function(int index, T element) convert) sync* {
    var index = 0;
    for (var element in this) {
      yield convert(index++, element);
    }
  }
}

extension CurrencyExtension on dynamic {
  String get withCurrency => "\$ $this";
}

extension StringExtension on String {
  Color get hexToColor {
    String hexColor = replaceAll('#', '0xFF');
    return Color(int.parse(hexColor));
  }
}
