import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../main.dart';
import '../components/custom_button.dart';
import '../../domain/provider/my_profile_provider.dart';

class ImagePickerDialog extends ConsumerWidget {
  const ImagePickerDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                title: language.gallery,
                icon: Icon(Icons.photo_library_outlined, size: 20.sp),
                onPress: () async {
                  final pickedFile = await ref.watch(imagePickerUtilsProvider).pickImageFromGallery(cropAspectRatioPreset: CropAspectRatioPreset.square);
                  if (pickedFile != null) {
                    ref.read(imagePickerProvider.notifier).state = pickedFile;
                  }
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomButton(
                title: language.camera,
                icon: Icon(Icons.camera_outlined, size: 20.sp),
                onPress: () async {
                  final pickedFile = await ref.watch(imagePickerUtilsProvider).captureImageFromCamera(cropAspectRatioPreset: CropAspectRatioPreset.square);
                  if (pickedFile != null) {
                    ref.read(imagePickerProvider.notifier).state = pickedFile;
                  }
                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
