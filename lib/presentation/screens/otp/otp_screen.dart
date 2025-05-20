import 'package:fashion_comerce_demo/core/constants/colors.dart';
import 'package:fashion_comerce_demo/core/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provider/otp_verify_provider.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_pin_code_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.otpVerification)), body: SafeArea(child: _buildOTPScreen()));
  }

  Widget _buildOTPScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
            child: Text(language.enterOTP, style: bodyTextStyle(fontWeight: FontWeight.w500)),
          ),
          _otpField(),
          _verifyButton(),
          _resendOTP(),
        ],
      ),
    );
  }

  Widget _otpField() {
    return Consumer(
      builder: (context, ref, _) {
        return Padding(padding: EdgeInsetsDirectional.only(top: 30.h), child: CustomPinCodeField(key: pinCodeKey));
      },
    );
  }

  Widget _verifyButton() {
    return Consumer(
      builder: (context, ref, _) {
        return CustomButton(
          title: language.verify,
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 30.h),
          onPress: () {
            ref.read(otpVerifyProvider(context));
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

        return CustomButton(
          title: remainingSeconds > 0 ? "${language.resendOTPIn} $minutes:${seconds.toString().padLeft(2, '0')}" : language.resendOTP,
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 30.h),
          borderedButton: remainingSeconds > 0,
          textColor: remainingSeconds > 0 ? colorTextLight : colorText,
          onPress:
              remainingSeconds > 0
                  ? null
                  : () {
                    ref.read(resendOTPProvider);
                  },
        );
      },
    );
  }
}
