import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/text_field_validators.dart';
import '../../core/utils/tools.dart';
import '../../domain/entities/user_entity.dart';
import '../../main.dart';
import '../components/custom_text_field.dart';
import '../provider/forgot_password_provider.dart';
import '../screens/forgotChangePass/forgot_change_password_screen.dart';
import 'common_dialog.dart';

class ForgotPasswordDialog extends ConsumerStatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  ConsumerState<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends ConsumerState<ForgotPasswordDialog> {
  final phoneNoTEC = TextEditingController();
  late final ProviderSubscription<AsyncValue<UserEntity?>> _listener;

  @override
  void initState() {
    super.initState();
    _listener = ref.listenManual(authServiceProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (!mounted) return;
          Navigator.of(context, rootNavigator: true).pop();
          openScreen(context, ForgotChangePasswordScreen());
        },
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    phoneNoTEC.dispose();
    _listener.close();
  }

  @override
  Widget build(BuildContext context) {
    final apiResponse = ref.watch(authServiceProvider);

    return CommonDialog(
      title: language.enterNumberToContinue,
      negativeText: language.cancel,
      positiveText: language.sendOTP,
      isLoading: apiResponse.isLoading,
      onPositiveClick: () {
        ref.read(authServiceProvider.notifier).callForgotPasswordApi(email: phoneNoTEC.text);
      },
      onNegativeClick: () => Navigator.pop(context),
      widget: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: CustomTextField(
          controller: phoneNoTEC,
          decoration: InputDecoration(labelText: language.emailOrMobile),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          validator: (value) {
            return TextFieldValidator.emptyValidator(value, message: language.enterEmailOrMobile);
          },
        ),
      ),
    );
  }
}
