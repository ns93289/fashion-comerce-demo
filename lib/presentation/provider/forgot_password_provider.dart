import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/text_field_validators.dart';
import '../../core/utils/tools.dart';
import '../../main.dart';
import '../../presentation/components/custom_text_field.dart';
import '../../presentation/dialogs/common_dialog.dart';
import 'forgot_change_password_provider.dart';

final forgotPasswordProvider = Provider.autoDispose.family<void, BuildContext>((ref, context) {
  final phoneNoTEC = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return CommonDialog(
        title: language.enterNumberToContinue,
        negativeText: language.cancel,
        positiveText: language.sendOTP,
        onPositiveClick: () {
          Navigator.pop(context);
          ref.read(changePasswordProvider(context));
        },
        onNegativeClick: () => Navigator.pop(context),
        widget: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: CustomTextField(
            controller: phoneNoTEC,
            decoration: InputDecoration(
              labelText: language.mobileNumber,
              icon: CountryCodePicker(
                initialSelection: DefaultData.countryCodeName,
                textStyle: bodyStyle(),
                padding: EdgeInsets.zero,
                favorite: [DefaultData.countryCodeName],
                onChanged: (value) {},
              ),
            ),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              return TextFieldValidator.emptyValidator(value, message: language.enterMobileNumber);
            },
          ),
        ),
      );
    },
  ).then((value) => FocusManager.instance.primaryFocus?.unfocus());
});
