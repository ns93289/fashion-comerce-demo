import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../core/utils/text_field_validators.dart';
import '../../../core/utils/tools.dart';
import '../../../data/dataSources/local/hive_constants.dart';
import '../../../data/dataSources/local/hive_helper.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../../../core/constants/colors.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../provider/my_profile_provider.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.myProfile)), body: SafeArea(child: _buildProfilePicture()));
  }

  Widget _buildProfilePicture() {
    return ValueListenableBuilder(
      valueListenable: userBox.listenable(),
      builder: (context, box, _) {
        final fullName = box.get(hiveFullName, defaultValue: "") ?? "";
        final email = box.get(hiveEmailAddress, defaultValue: "") ?? "";
        final phoneNo = box.get(hivePhoneNumber, defaultValue: "") ?? "";
        final countryCode = box.get(hiveCountryCode, defaultValue: "") ?? "";
        final filePath = box.get(hiveProfilePicture, defaultValue: "") ?? "";

        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsetsDirectional.only(bottom: 90.h),
              child: Form(
                key: profileFormKey,
                child: Column(children: [_profilePicture(filePath), _fullNameField(fullName), _emailField(email), _phoneField(phoneNo, countryCode)]),
              ),
            ),
            Align(alignment: Alignment.bottomCenter, child: _updateButton()),
          ],
        );
      },
    );
  }

  Widget _profilePicture(String filePath) {
    return Consumer(
      builder: (context, ref, _) {
        final file = ref.watch(imagePickerProvider);

        return Center(
          child: Padding(
            padding: EdgeInsetsDirectional.only(top: 20.h),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: colorMainBackground),
                  height: 80.sp,
                  width: 80.sp,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child:
                      file != null
                          ? Image.file(file, fit: BoxFit.cover)
                          : filePath.isNotEmpty
                          ? Image.file(File(filePath), fit: BoxFit.cover)
                          : Container(),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 60.sp, start: 60.sp),
                  child: GestureDetector(
                    onTap: () {
                      openImagePickerDialog(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorWhite,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(blurRadius: 2, spreadRadius: 2, color: colorShadow)],
                      ),
                      padding: EdgeInsets.all(4.sp),
                      child: Icon(Icons.edit_outlined, color: colorTextLight, size: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _fullNameField(String fullName) {
    return Consumer(
      builder: (context, ref, _) {
        final fullNameTEC = ref.watch(fullNameTECProvider);
        fullNameTEC.text = fullName;

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

  Widget _emailField(String email) {
    return Consumer(
      builder: (context, ref, _) {
        final emailTEC = ref.watch(emailTECProvider);
        emailTEC.text = email;

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

  Widget _phoneField(String mobileNo, String dialCode) {
    return Consumer(
      builder: (context, ref, _) {
        final phoneNoTEC = ref.watch(phoneNoTECProvider);
        phoneNoTEC.text = mobileNo;

        return Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
          child: CustomTextField(
            controller: phoneNoTEC,
            decoration: InputDecoration(
              labelText: language.mobileNumber,
              icon: CountryCodePicker(
                initialSelection: dialCode,
                textStyle: bodyTextStyle(),
                padding: EdgeInsets.zero,
                onChanged: (value) {
                  ref.read(countryCodeTECProvider.notifier).state = value;
                },
              ),
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.done,
            validator: (value) {
              return TextFieldValidator.emptyValidator(value, message: language.enterMobileNumber);
            },
          ),
        );
      },
    );
  }

  Widget _updateButton() {
    return Consumer(
      builder: (context, ref, _) {
        return CustomButton(
          title: language.update,
          margin: EdgeInsetsDirectional.only(bottom: 20.h),
          onPress: () {
            if (profileFormKey.currentState?.validate() ?? false) {
              final fullNameTEC = ref.watch(fullNameTECProvider);
              final emailTEC = ref.watch(emailTECProvider);
              final phoneNoTEC = ref.watch(phoneNoTECProvider);
              final countryCode = ref.watch(countryCodeTECProvider);
              final file = ref.watch(imagePickerProvider);

              putDataInUserBox(key: hiveFullName, value: fullNameTEC.text);
              putDataInUserBox(key: hiveEmailAddress, value: emailTEC.text);
              putDataInUserBox(key: hivePhoneNumber, value: phoneNoTEC.text);
              putDataInUserBox(key: hiveCountryCode, value: countryCode.dialCode);
              putDataInUserBox(key: hiveProfilePicture, value: file?.path);
              openSimpleSnackBar(language.profileUpdateSuccess);
            }
          },
        );
      },
    );
  }
}
