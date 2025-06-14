import 'package:fashion_comerce_demo/data/dataSources/local/hive_constants.dart';
import 'package:fashion_comerce_demo/data/dataSources/local/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/text_utils.dart';
import '../../../core/utils/tools.dart';
import '../../provider/navigation_provider.dart';
import '../../provider/otp_verify_provider.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_pin_code_field.dart';
import '../home/home_screen.dart';

class OtpScreen extends StatefulWidget {
  final bool isPhone;

  const OtpScreen({super.key, this.isPhone = false});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(), body: SafeArea(child: _buildOTPScreen()));
  }

  Widget _buildOTPScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
            child: Text(
              "${language.verifyYour}\n${widget.isPhone ? language.mobileNumber : language.emailAddress}",
              style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 35.h, start: 20.w, end: 20.w),
            child: Text(
              widget.isPhone
                  ? language.mobileVerifyMsg(TextUtils.maskMobileNumber(getStringDataFromUserBox(key: hivePhoneNumber)))
                  : language.emailVerifyMsg(TextUtils.maskEmailUsername(getStringDataFromUserBox(key: hiveEmailAddress))),
              style: bodyTextStyle(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
          _otpField(),
          _verifyButton(),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 25.h, start: 20.w, end: 20.w),
            child: Text(language.dontReceiveCode, style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
          ),
          _resendOTP(),
        ],
      ),
    );
  }

  Widget _otpField() {
    return Consumer(
      builder: (context, ref, _) {
        return Padding(padding: EdgeInsetsDirectional.only(top: 35.h), child: CustomPinCodeField(key: pinCodeKey));
      },
    );
  }

  Widget _verifyButton() {
    return Consumer(
      builder: (context, ref, _) {
        final apiResponse = ref.watch(authenticationServiceProvider);
        ref.listen(authenticationServiceProvider, (previous, next) {
          if (next.value != null) {
            bool isEmailVerified = getBoolDataFromUserBox(key: hiveEmailVerified);
            bool isPhoneVerified = getBoolDataFromUserBox(key: hivePhoneNumberVerified);
            if (isPhoneVerified && isEmailVerified) {
              ref.read(navigationServiceProvider).navigateToWithClearStack(HomeScreen());
            } else {
              ref.read(navigationServiceProvider).goBack(true);
            }
          } else if (next.hasError) {
            openSimpleSnackBar(next.error.toString());
          }
        });

        return CustomButton(
          title: language.txtContinue,
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 30.h),
          isLoading: apiResponse.isLoading,
          width: 1.sw,
          onPress: () {
            ref.read(otpVerifyProvider((context: context, isPhone: widget.isPhone)));
          },
        );
      },
    );
  }

  Widget _resendOTP() {
    return Consumer(
      builder: (context, ref, child) {
        final remainingSeconds = ref.watch(resendDurationProvider);

        final minutes = remainingSeconds ~/ 60;
        final seconds = remainingSeconds % 60;

        return Column(
          children: [
            GestureDetector(
              onTap:
                  remainingSeconds > 0
                      ? null
                      : () {
                        ref.read(resendOTPProvider);
                      },
              child: Padding(
                padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
                child: Text(language.resendNewCode, style: bodyTextStyle(fontWeight: FontWeight.bold, color: colorPrimary)),
              ),
            ),
            if (remainingSeconds > 0)
              Padding(
                padding: EdgeInsetsDirectional.only(top: 10.h, start: 20.w, end: 20.w),
                child: Text(
                  "${language.resendOTPIn} $minutes:${seconds.toString().padLeft(2, '0')}",
                  style: bodyTextStyle(fontSize: 14.sp, color: colorTextLight),
                ),
              ),
          ],
        );
      },
    );
  }
}
