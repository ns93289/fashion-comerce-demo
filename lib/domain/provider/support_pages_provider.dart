import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../../data/models/model_support_pages.dart';

final supportPagesProvider = Provider.autoDispose<List<ModelSupportPages>>((ref) {
  return [
    ModelSupportPages(pageTitle: language.privacyPolicy, pageUrl: "https://www.google.com"),
    ModelSupportPages(pageTitle: language.termsAndConditions, pageUrl: "https://www.google.com"),
    ModelSupportPages(pageTitle: language.contactUs, pageUrl: "https://www.google.com"),
    ModelSupportPages(pageTitle: language.faqs, pageUrl: "https://www.google.com"),
    ModelSupportPages(pageTitle: language.aboutUs, pageUrl: "https://www.google.com"),
  ];
});
