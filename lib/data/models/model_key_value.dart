import 'package:flutter/material.dart';

class ModelKeyValue {
  final String keyTitle;
  final dynamic valueData;
  bool? _setBold;
  Color? _valueColor;

  ModelKeyValue(this.keyTitle, this.valueData, {bool? setBold, Color? valueColor}) {
    _setBold = setBold;
    _valueColor = valueColor;
  }

  Color? get valueColor => _valueColor;

  bool get setBold => _setBold ?? false;
}
