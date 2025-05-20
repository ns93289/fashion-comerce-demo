import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/image_picker_utils.dart';
import '../../presentation/dialogs/image_picker_dialog.dart';

final fullNameTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final phoneNoTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final emailTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final countryCodeTECProvider = StateProvider<CountryCode>((ref) {
  return CountryCode(name: "US", dialCode: "+1", code: "US");
});

final imagePickerUtilsProvider = Provider<ImagePickerUtils>((ref) {
  return ImagePickerUtils();
});

final imagePickerProvider = StateProvider<File?>((ref) {
  return null;
});

final profileFormKey = GlobalKey<FormState>();

openImagePickerDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return ImagePickerDialog();
    },
  );
}
