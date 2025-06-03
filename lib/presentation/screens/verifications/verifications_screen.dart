import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/custom_icons.dart';
import '../../../core/utils/text_utils.dart';
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
    return Scaffold(appBar: CommonAppBar(title: Text(language.verificationPending)), body: SafeArea(child: _buildVerificationsScreen()));
  }

  Widget _buildVerificationsScreen() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
          child: Text(language.verificationsMsg, style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
          child: Text(language.verificationMsg2, style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
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

        return Container(
          decoration: BoxDecoration(border: Border.all(color: colorBorder), borderRadius: BorderRadius.circular(20.r)),
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 25.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Row(
                  children: [
                    Expanded(child: Text(language.emailVerification, style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600))),
                    Icon(isEmailVerified ? CustomIcons.checkCircle : CustomIcons.timesCircle, color: isEmailVerified ? colorGreen : colorRed),
                  ],
                ),
              ),
              Divider(color: colorBorder, height: 0, thickness: 1.sp),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Text(
                  language.byClickEmailVerify(TextUtils.maskEmailUsername(getStringDataFromUserBox(key: hiveEmailAddress))),
                  style: bodyTextStyle(fontSize: 12.sp),
                ),
              ),
              if (!isEmailVerified)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      title: language.changeEmail,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      fontSize: 12.sp,
                      height: 25.h,
                      borderedButton: true,
                      fontWeight: FontWeight.w500,
                      margin: EdgeInsetsDirectional.only(end: 10.w),
                    ),
                    CustomButton(
                      title: language.verify,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      fontSize: 12.sp,
                      height: 25.h,
                      fontWeight: FontWeight.w500,
                      margin: EdgeInsetsDirectional.only(end: 15.w),
                      onPress: () {
                        openScreenWithResult(context, OtpScreen()).then((value) {
                          bool isEmailVerified = getBoolDataFromUserBox(key: hiveEmailVerified);
                          bool isPhoneVerified = getBoolDataFromUserBox(key: hivePhoneNumberVerified);
                          if (isPhoneVerified && isEmailVerified) {
                            Future.delayed(Duration(seconds: 1), () {
                              if (!context.mounted) return;
                              openScreenWithClearStack(context, HomeScreen());
                            });
                          }
                        });
                      },
                    ),
                  ],
                ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }

  Widget _verifyPhoneButton() {
    return ValueListenableBuilder(
      valueListenable: userBox.listenable(),
      builder: (context, _, _) {
        bool isPhoneVerified = getBoolDataFromUserBox(key: hivePhoneNumberVerified);

        return Container(
          decoration: BoxDecoration(border: Border.all(color: colorBorder), borderRadius: BorderRadius.circular(20.r)),
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 25.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Row(
                  children: [
                    Expanded(child: Text(language.mobileNumberVerification, style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600))),
                    Icon(isPhoneVerified ? CustomIcons.checkCircle : CustomIcons.timesCircle, color: isPhoneVerified ? colorGreen : colorRed),
                  ],
                ),
              ),
              Divider(color: colorBorder, height: 0, thickness: 1.sp),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Text(
                  language.byClickMobileVerify(TextUtils.maskMobileNumber(getStringDataFromUserBox(key: hivePhoneNumber))),
                  style: bodyTextStyle(fontSize: 12.sp),
                ),
              ),
              if (!isPhoneVerified)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      title: language.changeMobileNumber,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      fontSize: 12.sp,
                      height: 25.h,
                      fontWeight: FontWeight.w500,
                      borderedButton: true,
                      margin: EdgeInsetsDirectional.only(end: 10.w),
                    ),
                    CustomButton(
                      title: language.verify,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      fontSize: 12.sp,
                      height: 25.h,
                      fontWeight: FontWeight.w500,
                      margin: EdgeInsetsDirectional.only(end: 15.w),
                      onPress: () {
                        openScreenWithResult(context, OtpScreen(isPhone: true)).then((value) {
                          bool isPhoneVerified = getBoolDataFromUserBox(key: hivePhoneNumberVerified);
                          bool isEmailVerified = getBoolDataFromUserBox(key: hiveEmailVerified);
                          if (isEmailVerified && isPhoneVerified) {
                            Future.delayed(Duration(seconds: 1), () {
                              if (!context.mounted) return;
                              openScreenWithClearStack(context, HomeScreen());
                            });
                          }
                        });
                      },
                    ),
                  ],
                ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }
}
