import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/text_field_validators.dart';
import '../../../core/utils/tools.dart';
import '../../../domain/entities/user_entity.dart';
import '../../provider/signup_provider.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../home/home_screen.dart';
import '../verifications/verifications_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.signUp)), body: SafeArea(child: _buildSignUpScreen()));
  }

  Widget _buildSignUpScreen() {
    return SingleChildScrollView(
      child: Form(
        key: signupFormKey,
        child: Column(
          children: [_fullNameField(), _emailField(), _phoneNumberField(), _passwordField(), _confirmPasswordField(), _termsAndConditions(), _signUpButton()],
        ),
      ),
    );
  }

  Widget _fullNameField() {
    return Consumer(
      builder: (context, ref, _) {
        final fullNameTEC = ref.watch(fullNameTECProvider);

        return Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
          child: CustomTextField(
            controller: fullNameTEC,
            decoration: InputDecoration(labelText: language.fullName),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) {
              return TextFieldValidator.emptyValidator(value, message: language.enterFullName);
            },
          ),
        );
      },
    );
  }

  Widget _emailField() {
    return Consumer(
      builder: (context, ref, _) {
        final emailTEC = ref.watch(emailTECProvider);

        return Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
          child: CustomTextField(
            controller: emailTEC,
            decoration: InputDecoration(labelText: language.emailAddress),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              return TextFieldValidator.emailValidator(value);
            },
          ),
        );
      },
    );
  }

  Widget _phoneNumberField() {
    return Consumer(
      builder: (context, ref, _) {
        final phoneNoTEC = ref.watch(phoneNoTECProvider);
        return Padding(
          padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
          child: CustomTextField(
            controller: phoneNoTEC,
            decoration: InputDecoration(labelText: language.mobileNumber),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              return TextFieldValidator.emptyValidator(value, message: language.enterMobileNumber);
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

  Widget _termsAndConditions() {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
      child: RichText(
        text: TextSpan(
          text: language.agreeWithOur,
          style: bodyStyle(fontSize: 14.sp),
          children: [
            TextSpan(
              text: " ${language.termsAndConditions}",
              recognizer: TapGestureRecognizer()..onTap = () {},
              style: bodyStyle(fontSize: 14.sp, color: colorPrimary, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return Consumer(
      builder: (context, ref, _) {
        final apiResponse = ref.watch(authenticationServiceProvider);
        ref.listen(authenticationServiceProvider, (previous, next) {
          if (next is AsyncData<UserEntity?>) {
            UserEntity? data = next.value;
            if (data != null) {
              if (data.mobileVerified && data.emailVerified) {
                openScreenWithClearStack(context, HomeScreen());
              } else {
                openScreen(context, VerificationsScreen());
              }
            }
          }
        });

        return CustomButton(
          title: language.signUp,
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
          isLoading: apiResponse.isLoading,
          onPress: () {
            if (signupFormKey.currentState!.validate()) {
              ref.read(signUpProvider(context));
            }
          },
        );
      },
    );
  }
}
