import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../../src/generated/l10n/app_localizations.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/modle_preference.dart';

final languagesProvider = Provider.autoDispose<List<ModelLanguage>>((ref) {
  return AppLocalizations.supportedLocales.map((e) {
    if (e.languageCode == LanguageCodes.spanish) {
      return (ModelLanguage(locale: Locale(LanguageCodes.spanish), language: "Spanish", title: "Español"));
    } else {
      return (ModelLanguage(locale: Locale(LanguageCodes.english), language: "English", title: "English"));
    }
  }).toList();
});

final selectedLanguageProvider = StateProvider<Locale>((ref) {
  return selectedLocale;
});
