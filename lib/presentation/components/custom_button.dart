import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../../core/utils/tools.dart';
import 'common_circle_progress_bar.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onPress;
  final double? width;
  final double? height;
  final double? fontSize;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final bool isLoading;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.title,
    this.onPress,
    this.width,
    this.height,
    this.margin,
    this.backgroundColor,
    this.isLoading = false,
    this.fontSize,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPress,
      child: Container(
        decoration: BoxDecoration(color: backgroundColor ?? colorPrimary, borderRadius: BorderRadius.circular(30.r)),
        constraints: BoxConstraints(minWidth: width ?? 120.w),
        width: width,
        height: height ?? 36.h,
        margin: margin,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
        child:
            isLoading
                ? CommonCircleProgressBar(color: colorWhite)
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        if (icon != null) Padding(padding: EdgeInsetsDirectional.only(end: 10.w), child: icon),
                        Text(title, style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
                      ],
                    ),
                  ],
                ),
      ),
    );
  }
}
