import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_constants.dart';

final localeProvider = StateProvider<Locale>((ref) => Locale(LanguageCodes.english));
