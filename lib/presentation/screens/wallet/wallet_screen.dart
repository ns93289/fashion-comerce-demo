import 'package:fashion_comerce_demo/presentation/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/decimal_text_input_formatter.dart';
import '../../../core/utils/text_field_validators.dart';
import '../../components/custom_text_field.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../main.dart';
import '../../components/common_circle_progress_bar.dart';
import '../../../domain/provider/wallet_provider.dart';
import '../../components/common_app_bar.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.wallet)), body: _buildWalletScreen());
  }

  Widget _buildWalletScreen() {
    return SingleChildScrollView(child: Column(children: [_walletView(), _amountTextField(), _addAmountButton()]));
  }

  Widget _walletView() {
    final result = ref.watch(walletAmountProvider);

    return Container(
      decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(10.r)),
      margin: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
      padding: EdgeInsetsDirectional.only(bottom: 15.h),
      width: 1.sw,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10.h), child: Text(language.walletBalance, style: bodyTextStyle(fontWeight: FontWeight.w500))),
          result.isLoading
              ? CommonCircleProgressBar(color: colorBlack, size: 25.sp, stroke: 2.sp)
              : Text(result.asData?.value.withCurrency ?? "0", style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 21.sp)),
        ],
      ),
    );
  }

  Widget _amountTextField() {
    final controller = ref.watch(walletAmountTECProvider);

    return Form(
      key: walletFormKey,
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
        child: CustomTextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: language.amount),
          textInputFormatters: [DecimalTextInputFormatter(maxDigits: 8, decimalRange: 2)],
          validator: (value) {
            return TextFieldValidator.emptyValidator(value, message: language.enterAmount);
          },
        ),
      ),
    );
  }

  Widget _addAmountButton() {
    return CustomButton(
      title: language.addAmount,
      margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
      onPress: () {
        if (walletFormKey.currentState?.validate() ?? false) {}
      },
    );
  }
}
