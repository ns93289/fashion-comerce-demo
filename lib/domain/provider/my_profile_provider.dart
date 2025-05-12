import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../core/utils/image_picker_utils.dart';

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
final countryCodeTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final profilePictureGalleryProvider = FutureProvider.autoDispose<File?>((ref) async {
  final imagePickerUtils = ref.read(imagePickerUtilsProvider);
  File? image = await imagePickerUtils.pickImageFromGallery();
  if (image != null) {
    String sourcePath = image.path;
    File? croppedImage = await imagePickerUtils.cropImageToAspectRatio(sourcePath: sourcePath, cropAspectRatioPreset: CropAspectRatioPreset.square);
    return croppedImage;
  }
  return null;
});

final profilePictureCameraProvider = FutureProvider.autoDispose<File?>((ref) async {
  final imagePickerUtils = ref.read(imagePickerUtilsProvider);
  File? image = await imagePickerUtils.captureImageFromCamera();
  if (image != null) {
    String sourcePath = image.path;
    File? croppedImage = await imagePickerUtils.cropImageToAspectRatio(sourcePath: sourcePath, cropAspectRatioPreset: CropAspectRatioPreset.square);
    return croppedImage;
  }
  return null;
});

final imagePickerUtilsProvider = Provider<ImagePickerUtils>((ref) {
  return ImagePickerUtils();
});
