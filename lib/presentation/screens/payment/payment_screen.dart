import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/extensions.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
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
    final walletAmount = ref.watch(walletAmountPro);

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
          _walletPayment(paymentType, walletAmount),
          _commonDiver(),
          _upiPayment(paymentType, walletAmount),
          _commonDiver(),
          _cardPayment(paymentType),
          _commonDiver(),
          _cashPayment(paymentType),
          _placeOrderButton(paymentType, walletAmount),
        ],
      ),
    );
  }

  Widget _walletPayment(int paymentType, num walletAmount) {
    return GestureDetector(
      onTap: () => ref.read(paymentTypePro.notifier).state = PaymentType.wallet,
      child: Container(
        color: colorWhite,
        margin: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
        child: Row(
          children: [
            Expanded(child: Text("${language.payByWallet} {${walletAmount.withCurrency}}", style: _titleStyle)),
            CustomRadio(selected: paymentType == PaymentType.wallet),
          ],
        ),
      ),
    );
  }

  Widget _upiPayment(int paymentType, num walletAmount) {
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

  Widget _placeOrderButton(int paymentType, num walletAmount) {
    return CustomButton(
      title: language.placeOrder,
      width: 1.sw,
      margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
      onPress: () async {
        ref.read(makePaymentPro((paymentType: paymentType, orderAmount: widget.orderAmount, walletAmount: walletAmount)));
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
