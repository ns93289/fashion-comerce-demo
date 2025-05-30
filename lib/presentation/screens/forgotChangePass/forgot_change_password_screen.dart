import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/text_field_validators.dart';
import '../../../core/utils/tools.dart';
import '../../../domain/entities/user_entity.dart';
import '../../components/common_app_bar.dart';
import '../../provider/forgot_change_password_provider.dart';
import '../../../main.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';

class ForgotChangePasswordScreen extends StatefulWidget {
  const ForgotChangePasswordScreen({super.key});

  @override
  State<ForgotChangePasswordScreen> createState() => _ForgotChangePasswordScreenState();
}

class _ForgotChangePasswordScreenState extends State<ForgotChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Text(language.changePassword)),
      body: SingleChildScrollView(
        child: Form(key: changePasswordFormKey, child: Column(children: [_otpField(), _passwordField(), _confirmPasswordField(), _changePasswordButton()])),
      ),
    );
  }

  Widget _otpField() {
    return Consumer(
      builder: (context, ref, _) {
        final otpTEC = ref.watch(otpTECProvider);
        return Padding(
          padding: EdgeInsetsDirectional.only(top: 30.h, start: 20.w, end: 20.w),
          child: CustomTextField(
            controller: otpTEC,
            decoration: InputDecoration(labelText: language.otp),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 6,
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
            decoration: InputDecoration(labelText: language.newPassword),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            obscureText: true,
            validator: (value) {
              return TextFieldValidator.passwordValidator(password: value, message: language.enterNewPassword);
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

  Widget _changePasswordButton() {
    return Consumer(
      builder: (context, ref, _) {
        final apiResponse = ref.watch(authenticationServiceProvider);
        ref.listen(authenticationServiceProvider, (previous, next) {
          if (next is AsyncData<UserEntity?>) {
            UserEntity? data = next.value;
            if (data != null) {
              openSimpleSnackBar(data.message);
              Navigator.pop(context);
            }
          }
        });

        return CustomButton(
          title: language.change,
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
          isLoading: apiResponse.isLoading,
          onPress: () {
            if (changePasswordFormKey.currentState!.validate()) {
              ref.read(changePasswordProvider);
            }
          },
        );
      },
    );
  }
}
