import 'package:fashion_comerce_demo/core/constants/colors.dart';
import 'package:fashion_comerce_demo/core/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/provider/otp_verify_provider.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_button.dart';

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
        ],
      ),
    );
  }

  Widget _otpField() {
    return Consumer(
      builder: (context, ref, _) {
        return Padding(
          padding: EdgeInsetsDirectional.only(top: 30.h),
          child: OtpTextField(
            numberOfFields: 6,
            fieldHeight: 35.sp,
            fieldWidth: 35.sp,
            alignment: Alignment.center,
            contentPadding: EdgeInsets.zero,
            margin: EdgeInsets.symmetric(horizontal: 7.5.w),
            borderColor: colorTextLight,
            enabledBorderColor: colorTextLight,
            focusedBorderColor: colorPrimary,
            showFieldAsBox: true,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textStyle: bodyTextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            onSubmit: (value) {
              ref.read(otpTextProvider.notifier).state = value;
            },
          ),
        );
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
}
