import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../core/constants/colors.dart';
import '../../../data/dataSources/local/hive_constants.dart';
import '../../../data/dataSources/local/hive_helper.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/tools.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_button.dart';
import '../home/home_screen.dart';
import '../otp/otp_screen.dart';

class VerificationsScreen extends StatefulWidget {
  const VerificationsScreen({super.key});

  @override
  State<VerificationsScreen> createState() => _VerificationsScreenState();
}

class _VerificationsScreenState extends State<VerificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.otpVerification)), body: SafeArea(child: _buildVerificationsScreen()));
  }

  Widget _buildVerificationsScreen() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
          child: Text(language.verificationsMsg, style: bodyTextStyle(fontWeight: FontWeight.w500)),
        ),
        _verifyEmailButton(),
        _verifyPhoneButton(),
      ],
    );
  }

  Widget _verifyEmailButton() {
    return ValueListenableBuilder(
      valueListenable: userBox.listenable(),
      builder: (context, _, _) {
        bool isEmailVerified = getBoolDataFromUserBox(key: hiveEmailVerified);
        return CustomButton(
          title: language.verifyEmail,
          backgroundColor: isEmailVerified ? colorGreen : colorPrimary,
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 30.h),
          icon: isEmailVerified ? Icon(Icons.check_sharp, color: colorWhite) : null,
          textColor: isEmailVerified ? colorWhite : colorText,
          enabled: !isEmailVerified,
          onPress: () {
            openScreenWithResult(context, OtpScreen()).then((value) {
              bool isPhoneVerified = getBoolDataFromUserBox(key: hivePhoneNumberVerified);
              if (isPhoneVerified) {
                Future.delayed(Duration(seconds: 1), () {
                  if (!context.mounted) return;
                  openScreenWithClearStack(context, HomeScreen());
                });
              }
            });
          },
        );
      },
    );
  }

  Widget _verifyPhoneButton() {
    return ValueListenableBuilder(
      valueListenable: userBox.listenable(),
      builder: (context, _, _) {
        bool isPhoneVerified = getBoolDataFromUserBox(key: hivePhoneNumberVerified);
        return CustomButton(
          title: language.verifyMobile,
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
          icon: isPhoneVerified ? Icon(Icons.check_sharp, color: colorWhite) : null,
          backgroundColor: isPhoneVerified ? colorGreen : colorPrimary,
          textColor: isPhoneVerified ? colorWhite : colorText,
          enabled: !isPhoneVerified,
          onPress: () {
            openScreenWithResult(context, OtpScreen(isPhone: true)).then((value) {
              bool isEmailVerified = getBoolDataFromUserBox(key: hiveEmailVerified);
              if (isEmailVerified) {
                Future.delayed(Duration(seconds: 1), () {
                  if (!context.mounted) return;
                  openScreenWithClearStack(context, HomeScreen());
                });
              }
            });
          },
        );
      },
    );
  }
}
