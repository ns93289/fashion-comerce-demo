import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../utils/tools.dart';
import 'common_circle_progress_bar.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onPress;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final bool isLoading;

  const CustomButton({super.key, required this.title, this.onPress, this.width, this.height, this.margin, this.backgroundColor, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPress,
      child: Container(
        decoration: BoxDecoration(color: backgroundColor ?? colorPrimary, borderRadius: BorderRadius.circular(5.r)),
        constraints: BoxConstraints(minWidth: width ?? 120.w),
        width: width,
        height: height ?? 36.h,
        margin: margin,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
        child:
            isLoading
                ? CommonCircleProgressBar(color: colorWhite)
                : Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(title, style: bodyTextStyle(color: colorWhite, fontWeight: FontWeight.w500))]),
      ),
    );
  }
}
