import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/tools.dart';
import '../../main.dart';
import '../components/custom_button.dart';

class CommonDialog extends StatelessWidget {
  final String title;
  final String? positiveText;
  final String? negativeText;
  final Function() onPositiveClick;
  final Function()? onNegativeClick;

  const CommonDialog({super.key, required this.title, required this.onPositiveClick, this.onNegativeClick, this.positiveText, this.negativeText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: bodyTextStyle()),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    title: negativeText ?? language.cancel,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                    fontSize: 14.sp,
                    height: 25.h,
                    borderedButton: true,
                    onPress: () => onNegativeClick?.call(),
                  ),
                  if (onNegativeClick != null) SizedBox(width: 10.w),
                  CustomButton(
                    title: positiveText ?? language.okay,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                    fontSize: 14.sp,
                    height: 25.h,
                    onPress: () => onPositiveClick.call(),
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
