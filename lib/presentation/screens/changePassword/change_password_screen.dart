import 'package:fashion_comerce_demo/core/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/text_field_validators.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../../provider/change_password_provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.changePassword)), body: SafeArea(child: _buildChangePasswordScreen()));
  }

  Widget _buildChangePasswordScreen() {
    return SingleChildScrollView(
      child: Form(
        key: changePasswordFormKey,
        child: Column(children: [_oldPasswordField(), _newPasswordField(), _confirmPasswordField(), _changePasswordButton()]),
      ),
    );
  }

  Widget _oldPasswordField() {
    return Consumer(
      builder: (context, ref, _) {
        final passwordTEC = ref.watch(passwordTECProvider);
        return Padding(
          padding: EdgeInsetsDirectional.only(top: 30.h, start: 20.w, end: 20.w),
          child: CustomTextField(
            controller: passwordTEC,
            decoration: InputDecoration(labelText: language.oldPassword),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            obscureText: true,
            validator: (value) {
              return TextFieldValidator.emptyValidator(value, message: language.enterOldPassword);
            },
          ),
        );
      },
    );
  }

  Widget _newPasswordField() {
    return Consumer(
      builder: (context, ref, _) {
        final passwordTEC = ref.watch(newPasswordTECProvider);
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
        final passwordTEC = ref.watch(newPasswordTECProvider);
        final confirmPasswordTEC = ref.watch(confirmPasswordTECProvider);
        return Padding(
          padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
          child: CustomTextField(
            controller: confirmPasswordTEC,
            decoration: InputDecoration(labelText: language.confirmPassword),
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
