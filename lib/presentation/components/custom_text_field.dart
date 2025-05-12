import 'package:fashion_comerce_demo/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/tools.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator? validator;
  final Function(String? value)? onChanged;
  final InputDecoration? decoration;
  final int? maxLength;

  const CustomTextField({
    super.key,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.style,
    this.validator,
    this.onChanged,
    this.decoration,
    this.inputFormatters,
    this.maxLength,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final normalBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), borderSide: BorderSide(color: colorTextLight, width: 1.sp));
    final focusBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), borderSide: BorderSide(color: colorPrimary, width: 1.sp));
    final errorBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), borderSide: BorderSide(color: colorRed, width: 1.sp));

    final InputDecoration decoration = InputDecoration(
      hintText: widget.decoration?.hintText,
      labelText: widget.decoration?.labelText,
      hintStyle: widget.decoration?.hintStyle ?? bodyTextStyle(fontSize: 14.sp, color: colorTextLight),
      labelStyle: widget.decoration?.hintStyle ?? bodyTextStyle(fontSize: 14.sp, color: colorTextLight),
      border: normalBorder,
      disabledBorder: normalBorder,
      enabledBorder: normalBorder,
      focusedBorder: focusBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
      contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      isDense: true,
      prefixIcon: widget.decoration?.icon,
      errorStyle: widget.decoration?.errorStyle ?? bodyTextStyle(fontSize: 10.sp, color: colorRed),
    );

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: widget.style ?? bodyTextStyle(),
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      cursorColor: colorPrimary,
      cursorErrorColor: colorRed,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: decoration,
    );
  }
}
