import 'package:fashion_comerce_demo/presentation/components/common_circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/extensions.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/tools.dart';
import '../../../domain/entities/wallet_entity.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../../core/constants/app_constants.dart';
import '../../provider/payment_provider.dart';
import '../../components/custom_button.dart';
import '../../components/custom_radio.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final num orderAmount;

  const PaymentScreen({super.key, required this.orderAmount});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  final _titleStyle = bodyTextStyle(fontWeight: FontWeight.w600);
  final _textStyle = bodyTextStyle(fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.payment)), body: SafeArea(child: _buildPaymentScreen()));
  }

  Widget _buildPaymentScreen() {
    final paymentType = ref.watch(paymentTypePro);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), border: Border.all(color: colorBorder, width: 1.sp)),
            padding: EdgeInsets.all(15.sp),
            margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
            child: Row(
              children: [
                Expanded(child: Text(language.totalBill, style: _titleStyle)),
                Text(widget.orderAmount.withCurrency, style: bodyTextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
              ],
            ),
          ),
          _walletPayment(paymentType),
          _commonDiver(),
          _upiPayment(paymentType),
          _commonDiver(),
          _cardPayment(paymentType),
          _commonDiver(),
          _cashPayment(paymentType),
          _placeOrderButton(paymentType),
        ],
      ),
    );
  }

  Widget _walletPayment(int paymentType) {
    final response = ref.watch(walletServiceProvider);

    return GestureDetector(
      onTap: () => ref.read(paymentTypePro.notifier).state = PaymentType.wallet,
      child: Container(
        color: colorWhite,
        margin: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
        child: Row(
          children: [
            Text(language.payByWallet, style: _titleStyle),
            response.when(
              data: (data) {
                WalletEntity walletEntity = data as WalletEntity;
                return Expanded(child: Text(" {${walletEntity.walletBalance.withCurrency}}", style: _titleStyle));
              },
              error: (error, stackTrace) => Spacer(),
              loading: () => Expanded(child: CommonCircleProgressBar(size: 15.sp)),
            ),
            CustomRadio(selected: paymentType == PaymentType.wallet),
          ],
        ),
      ),
    );
  }

  Widget _upiPayment(int paymentType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 20.w), child: Text(language.payByUPI, style: _titleStyle)),
        GestureDetector(
          onTap: () => ref.read(paymentTypePro.notifier).state = PaymentType.googlePay,
          child: Container(
            color: colorWhite,
            margin: EdgeInsetsDirectional.only(top: 15.h, start: 20.w, end: 20.w),
            child: Row(children: [Expanded(child: Text(language.googlePay, style: _textStyle)), CustomRadio(selected: paymentType == PaymentType.googlePay)]),
          ),
        ),
        GestureDetector(
          onTap: () => ref.read(paymentTypePro.notifier).state = PaymentType.amazonPay,
          child: Container(
            color: colorWhite,
            margin: EdgeInsetsDirectional.only(top: 15.h, start: 20.w, end: 20.w),
            child: Row(children: [Expanded(child: Text(language.amazonPay, style: _textStyle)), CustomRadio(selected: paymentType == PaymentType.amazonPay)]),
          ),
        ),
        GestureDetector(
          onTap: () => ref.read(paymentTypePro.notifier).state = PaymentType.payPal,
          child: Container(
            color: colorWhite,
            margin: EdgeInsetsDirectional.only(top: 15.h, start: 20.w, end: 20.w),
            child: Row(children: [Expanded(child: Text(language.paypal, style: _textStyle)), CustomRadio(selected: paymentType == PaymentType.payPal)]),
          ),
        ),
      ],
    );
  }

  Widget _cashPayment(int paymentType) {
    return GestureDetector(
      onTap: () => ref.read(paymentTypePro.notifier).state = PaymentType.cash,
      child: Container(
        color: colorWhite,
        margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
        child: Row(children: [Expanded(child: Text(language.payByCash, style: _titleStyle)), CustomRadio(selected: paymentType == PaymentType.cash)]),
      ),
    );
  }

  Widget _cardPayment(int paymentType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 20.w), child: Text(language.payByCard, style: _titleStyle)),
        GestureDetector(
          onTap: () => ref.read(paymentTypePro.notifier).state = PaymentType.card,
          child: Container(
            color: colorWhite,
            margin: EdgeInsetsDirectional.only(top: 15.h, start: 20.w, end: 20.w),
            child: Row(children: [Expanded(child: Text("xxxx xxxx xxxx 1111", style: _textStyle)), CustomRadio(selected: paymentType == PaymentType.card)]),
          ),
        ),
      ],
    );
  }

  Widget _placeOrderButton(int paymentType) {
    return CustomButton(
      title: language.placeOrder,
      width: 1.sw,
      margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
      onPress: () {
        if (paymentType == 0) {
          openSimpleSnackBar(language.selectPayment);
        } else {
          ref.read(placeOrderProvider(context));
        }
      },
    );
  }

  Widget _commonDiver() {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 15.h, horizontal: 20.w),
      child: Divider(height: 0, thickness: 1.sp, color: colorMainBackground),
    );
  }
}
