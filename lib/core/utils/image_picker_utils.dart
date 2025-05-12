import 'dart:io';

import 'package:fashion_comerce_demo/core/constants/colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  final ImagePicker picker = ImagePicker();

  Future<File?> pickImageFromGallery({CropAspectRatioPreset? cropAspectRatioPreset}) async {
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File? croppedImage = await cropImageToAspectRatio(sourcePath: image.path, cropAspectRatioPreset: cropAspectRatioPreset);
      if (croppedImage != null) {
        return croppedImage;
      }
      return File(image.path);
    } else {
      return null;
    }
  }

  Future<File?> captureImageFromCamera({CropAspectRatioPreset? cropAspectRatioPreset}) async {
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      File? croppedImage = await cropImageToAspectRatio(sourcePath: image.path, cropAspectRatioPreset: cropAspectRatioPreset);
      if (croppedImage != null) {
        return croppedImage;
      }
      return File(image.path);
    } else {
      return null;
    }
  }

  Future<File?> cropImageToAspectRatio({required String sourcePath, CropAspectRatioPreset? cropAspectRatioPreset}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Cropper",
          aspectRatioPresets: cropAspectRatioPreset != null ? [cropAspectRatioPreset] : [CropAspectRatioPreset.original],
          toolbarColor: colorWhite,
          toolbarWidgetColor: colorBlack,
          initAspectRatio: cropAspectRatioPreset ?? CropAspectRatioPreset.original,
          lockAspectRatio: cropAspectRatioPreset != null ? true : false,
        ),
        IOSUiSettings(
          title: "Cropper",
          aspectRatioPresets: cropAspectRatioPreset != null ? [cropAspectRatioPreset] : [CropAspectRatioPreset.original],
          aspectRatioLockEnabled: cropAspectRatioPreset != null ? true : false,
        ),
      ],
    );
    if (croppedFile != null) {
      return File(croppedFile.path);
    } else {
      return null;
    }
  }
}
