import 'package:fashion_comerce_demo/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/text_field_validators.dart';
import '../../core/utils/tools.dart';
import '../../domain/provider/forgot_change_password_provider.dart';
import '../../main.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';

class ForgotChangePasswordDialog extends StatefulWidget {
  final String title;
  final Function() onPositiveClick;
  final Function()? onNegativeClick;

  const ForgotChangePasswordDialog({super.key, required this.title, required this.onPositiveClick, this.onNegativeClick});

  @override
  State<ForgotChangePasswordDialog> createState() => _ForgotChangePasswordDialogState();
}

class _ForgotChangePasswordDialogState extends State<ForgotChangePasswordDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(10.r)),
          child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Form(
              key: changePasswordFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.title, style: bodyTextStyle()),
                  _otpField(),
                  _passwordField(),
                  _confirmPasswordField(),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          title: language.cancel,
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                          fontSize: 14.sp,
                          height: 25.h,
                          borderedButton: true,
                          onPress: () => widget.onNegativeClick?.call(),
                        ),
                        SizedBox(width: 20.w),
                        CustomButton(
                          title: language.change,
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                          fontSize: 14.sp,
                          height: 25.h,
                          onPress: () => widget.onPositiveClick.call(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _otpField() {
    return Consumer(
      builder: (context, ref, _) {
        final otpTEC = ref.watch(otpTECProvider);
        return Padding(
          padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
          child: CustomTextField(
            controller: otpTEC,
            decoration: InputDecoration(labelText: language.otp),
            textInputAction: TextInputAction.next,
            obscureText: true,
            validator: (value) {
              return TextFieldValidator.otpValidator(otp: value);
            },
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return Consumer(
      builder: (context, ref, _) {
        final passwordTEC = ref.watch(passwordTECProvider);
        return Padding(
          padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
          child: CustomTextField(
            controller: passwordTEC,
            decoration: InputDecoration(labelText: language.password),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            obscureText: true,
            validator: (value) {
              return TextFieldValidator.passwordValidator(password: value);
            },
          ),
        );
      },
    );
  }

  Widget _confirmPasswordField() {
    return Consumer(
      builder: (context, ref, _) {
        final passwordTEC = ref.watch(passwordTECProvider);
        final confirmPasswordTEC = ref.watch(confirmPasswordTECProvider);
        return Padding(
          padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
          child: CustomTextField(
            controller: confirmPasswordTEC,
            decoration: InputDecoration(labelText: language.password),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            obscureText: true,
            validator: (value) {
              return TextFieldValidator.passwordMatchValidator(password: passwordTEC.text, confirmPassword: value);
            },
          ),
        );
      },
    );
  }
}
