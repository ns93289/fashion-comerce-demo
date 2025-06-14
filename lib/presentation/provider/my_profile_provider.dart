import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/user_profile_service.dart';
import '../../core/utils/image_picker_utils.dart';
import '../../data/repositories/user_profile_repo_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_profile_repo.dart';

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

final userProfileRepoProvider = Provider.autoDispose<UserProfileRepo>((ref) {
  return UserProfileRepoImpl();
});
final userProfileServiceProvider = StateNotifierProvider<UserProfileService, AsyncValue<UserEntity?>>((ref) {
  return UserProfileService(ref.watch(userProfileRepoProvider));
});
final updateProfileProvider = Provider.autoDispose<void>((ref) {
  final fullNameTEC = ref.watch(fullNameTECProvider);
  final emailTEC = ref.watch(emailTECProvider);
  final phoneNoTEC = ref.watch(phoneNoTECProvider);
  final file = ref.watch(imagePickerProvider);

  Future.microtask(() {
    ref
        .read(userProfileServiceProvider.notifier)
        .callUpdateProfileApi(email: emailTEC.text, phoneNumber: phoneNoTEC.text, name: fullNameTEC.text, filePath: file?.path);
  });
});

final profileFormKey = GlobalKey<FormState>();
