import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/theme.dart';
import '../../core/utils/tools.dart';
import 'common_circle_progress_bar.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onPress;
  final double? width;
  final double? height;
  final double? fontSize;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final bool isLoading;
  final bool borderedButton;
  final bool enabled;
  final Widget? icon;
  final Widget? customWidget;
  final FontWeight? fontWeight;

  const CustomButton({
    super.key,
    required this.title,
    this.onPress,
    this.width,
    this.height,
    this.margin,
    this.backgroundColor,
    this.isLoading = false,
    this.borderedButton = false,
    this.fontSize,
    this.icon,
    this.padding,
    this.textColor,
    this.enabled = true,
    this.fontWeight,
    this.borderColor,
    this.customWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading || !enabled || customWidget != null ? null : onPress,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? (borderedButton ? Colors.transparent : colorPrimary),
          borderRadius: BorderRadius.circular(10.r),
          border: borderedButton ? Border.all(color: borderColor ?? colorBorder, width: 1.sp) : null,
        ),
        constraints: BoxConstraints(minWidth: width ?? 50.w),
        width: width,
        height: height ?? 40.h,
        margin: margin,
        padding: padding ?? EdgeInsetsDirectional.symmetric(horizontal: 20.w),
        child:
            isLoading
                ? CommonCircleProgressBar(color: colorWhite)
                : customWidget ??
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (icon != null) Padding(padding: EdgeInsetsDirectional.only(end: 10.w), child: icon),
                            Text(title, style: bodyTextStyle(fontWeight: fontWeight ?? FontWeight.bold, fontSize: fontSize ?? 18.sp, color: textColor)),
                          ],
                        ),
                      ],
                    ),
      ),
    );
  }
}
