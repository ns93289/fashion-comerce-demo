import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../core/constants/colors.dart';
import '../../main.dart';
import '../components/close_button.dart';
import '../components/custom_button.dart';
import '../provider/my_profile_provider.dart';
import '../provider/navigation_provider.dart';

class ImagePickerBottomSheet extends ConsumerWidget {
  const ImagePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(alignment: AlignmentDirectional.bottomEnd, child: CommonCloseButton()),
            Container(
              decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r))),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                        ref.read(navigationServiceProvider).goBack();
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomButton(
                      title: language.camera,
                      icon: Icon(Icons.camera_outlined, size: 20.sp),
                      onPress: () async {
                        final pickedFile = await ref
                            .watch(imagePickerUtilsProvider)
                            .captureImageFromCamera(cropAspectRatioPreset: CropAspectRatioPreset.square);
                        if (pickedFile != null) {
                          ref.read(imagePickerProvider.notifier).state = pickedFile;
                        }
                        ref.read(navigationServiceProvider).goBack();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
