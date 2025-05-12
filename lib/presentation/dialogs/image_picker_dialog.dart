import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../../main.dart';
import '../components/custom_button.dart';
import '../../domain/provider/my_profile_provider.dart';

class ImagePickerDialog extends ConsumerWidget {
  final Function(String)? onImageSelected;

  const ImagePickerDialog({this.onImageSelected, super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: colorWhite),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                title: language.gallery,
                icon: Icon(Icons.photo_library_outlined, size: 20.sp),
                onPress: () {
                  final fileResult = ref.watch(profilePictureGalleryProvider);
                  fileResult.whenData((value) {
                    if (value != null) {
                      onImageSelected?.call(value.path);
                      Navigator.pop(context);
                    }
                  });
                },
              ),
            ),
            Expanded(
              child: CustomButton(
                title: language.camera,
                icon: Icon(Icons.camera_outlined, size: 20.sp),
                onPress: () {
                  final fileResult = ref.watch(profilePictureCameraProvider);
                  fileResult.whenData((value) {
                    if (value != null) {
                      onImageSelected?.call(value.path);
                      Navigator.pop(context);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
