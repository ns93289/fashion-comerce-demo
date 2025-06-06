import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/theme.dart';
import '../../main.dart';
import '../components/custom_button.dart';

class CommonDialog extends StatefulWidget {
  final String title;
  final String? positiveText;
  final String? negativeText;
  final Widget? widget;
  final bool isLoading;
  final Function() onPositiveClick;
  final Function()? onNegativeClick;

  const CommonDialog({
    super.key,
    required this.title,
    required this.onPositiveClick,
    this.onNegativeClick,
    this.positiveText,
    this.negativeText,
    this.widget,
    this.isLoading = false,
  });

  @override
  State<CommonDialog> createState() => _CommonDialogState();
}

class _CommonDialogState extends State<CommonDialog> {
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
            Text(widget.title, style: bodyTextStyle()),
            if (widget.widget != null) widget.widget!,
            Padding(
              padding: EdgeInsetsDirectional.only(top: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    title: widget.negativeText ?? language.cancel,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                    fontSize: 14.sp,
                    height: 25.h,
                    borderedButton: true,
                    onPress: () => widget.onNegativeClick?.call(),
                  ),
                  if (widget.onNegativeClick != null) SizedBox(width: 10.w),
                  CustomButton(
                    title: widget.positiveText ?? language.okay,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                    fontSize: 14.sp,
                    height: 25.h,
                    isLoading: widget.isLoading,
                    onPress: () => widget.onPositiveClick.call(),
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
