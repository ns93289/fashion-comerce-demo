import 'package:flutter/material.dart';

class ModelLanguage {
  Locale? _locale;
  String? _language;
  String? _title;

  ModelLanguage({Locale? locale, String? language, String? title}) {
    _locale = locale;
    _language = language;
    _title = title;
  }

  Locale get locale => _locale ?? Locale("en");

  String get language => _language ?? "";

  String get title => _title ?? "";
}
