import 'package:flutter/material.dart';

class ModelKeyValue {
  final String keyTitle;
  final dynamic valueData;
  bool? _setBold;
  bool? _setDivider;
  Color? _valueColor;

  ModelKeyValue(this.keyTitle, this.valueData, {bool? setBold, Color? valueColor, bool? setDivider}) {
    _setBold = setBold;
    _valueColor = valueColor;
    _setDivider = setDivider;
  }

  Color? get valueColor => _valueColor;

  bool get setBold => _setBold ?? false;

  bool get setDivider => _setDivider ?? false;
}
