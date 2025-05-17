import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/colors.dart';
import '../../../domain/provider/forgot_password_provider.dart';
import '../../../domain/provider/login_provider.dart';
import '../../components/custom_button.dart';
import '../../../core/utils/text_field_validators.dart';
import '../../../core/utils/tools.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_text_field.dart';
import '../signUp/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(toolbarHeight: 0), body: SafeArea(child: _buildLoginScreen()));
  }

  Widget _buildLoginScreen() {
    return SingleChildScrollView(
      child: Form(
        key: loginFormKey,
        child: Column(children: [_appLogoAndName(), _phoneNumberField(), _passwordField(), _forgotPassword(), _loginButton(), _registerButton()]),
      ),
    );
  }

  Widget _appLogoAndName() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Image.asset("assets/images/splash_image.webp", height: 150.h, fit: BoxFit.cover, width: 1.sw),
        ),
        Text(language.appName, style: bodyTextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colorPrimary)),
      ],
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
            decoration: InputDecoration(
              labelText: language.mobileNumber,
              icon: CountryCodePicker(
                initialSelection: DefaultData.countryCodeName,
                textStyle: bodyTextStyle(),
                padding: EdgeInsets.zero,
                favorite: [DefaultData.countryCodeName],
                onChanged: (value) {
                  ref.read(countryCodeTECProvider.notifier).state = value;
                },
              ),
            ),
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
            textInputAction: TextInputAction.done,
            obscureText: true,
            validator: (value) {
              return TextFieldValidator.emptyValidator(value, message: language.enterPassword);
            },
          ),
        );
      },
    );
  }

  Widget _forgotPassword() {
    return Consumer(
      builder: (context, ref, _) {
        return Align(
          alignment: AlignmentDirectional.topEnd,
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
            child: TextButton(
              onPressed: () {
                ref.read(forgotPasswordProvider(context));
              },
              child: Text(language.forgotPassword, style: bodyTextStyle(fontSize: 12.sp)),
            ),
          ),
        );
      },
    );
  }

  Widget _registerButton() {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
      child: RichText(
        text: TextSpan(
          text: language.dontHaveAccount,
          style: bodyTextStyle(fontSize: 14.sp),
          children: [
            TextSpan(
              text: " ${language.registerHere}",
              recognizer: TapGestureRecognizer()..onTap = () => openScreen(context, SignUpScreen()),
              style: bodyTextStyle(fontSize: 14.sp, color: colorPrimary, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Consumer(
      builder: (context, ref, _) {
        return CustomButton(
          title: language.login,
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 10.h),
          onPress: () {
            if (loginFormKey.currentState!.validate()) {
              ref.read(loginCheckProvider(context));
            }
          },
        );
      },
    );
  }
}
