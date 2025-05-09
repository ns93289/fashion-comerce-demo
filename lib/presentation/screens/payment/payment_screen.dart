import 'package:fashion_comerce_demo/data/dataSources/local/hive_helper.dart';
import 'package:fashion_comerce_demo/presentation/screens/orderPlaced/order_placed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../../core/constants/app_constants.dart';
import '../../../domain/provider/payment_provider.dart';
import '../../components/custom_button.dart';
import '../../components/custom_radio.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final num orderAmount;

  const PaymentScreen({super.key, required this.orderAmount});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text("${language.payment} - ${widget.orderAmount}")), body: SafeArea(child: _buildPaymentScreen()));
  }

  Widget _buildPaymentScreen() {
    final paymentType = ref.watch(paymentTypePro);
    final walletAmount = ref.watch(walletAmountPro);

    return Stack(
      children: [
        SingleChildScrollView(child: Column(children: [_walletPayment(paymentType, walletAmount), _cashPayment(paymentType), _cardPayment(paymentType)])),
        _placeOrderButton(paymentType, walletAmount),
      ],
    );
  }

  Widget _walletPayment(int paymentType, num walletAmount) {
    return GestureDetector(
      onTap: () => ref.read(paymentTypePro.notifier).state = PaymentType.wallet,
      child: Container(
        decoration: BoxDecoration(color: colorWhite, boxShadow: [BoxShadow(blurRadius: 5, spreadRadius: 0, color: colorShadow, offset: Offset(0, 2))]),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        margin: EdgeInsetsDirectional.only(top: 10.h),
        child: Row(
          children: [
            Expanded(child: Text("${language.wallet} - ${walletAmount.withCurrency}", style: bodyTextStyle())),
            CustomRadio(selected: paymentType == PaymentType.wallet),
          ],
        ),
      ),
    );
  }

  Widget _cashPayment(int paymentType) {
    return GestureDetector(
      onTap: () => ref.read(paymentTypePro.notifier).state = PaymentType.cash,
      child: Container(
        decoration: BoxDecoration(color: colorWhite, boxShadow: [BoxShadow(blurRadius: 5, spreadRadius: 0, color: colorShadow, offset: Offset(0, 2))]),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        margin: EdgeInsetsDirectional.only(top: 20.h),
        child: Row(children: [Expanded(child: Text(language.cashOnD, style: bodyTextStyle())), CustomRadio(selected: paymentType == PaymentType.cash)]),
      ),
    );
  }

  Widget _cardPayment(int paymentType) {
    return GestureDetector(
      onTap: () => ref.read(paymentTypePro.notifier).state = PaymentType.card,
      child: Container(
        decoration: BoxDecoration(color: colorWhite, boxShadow: [BoxShadow(blurRadius: 5, spreadRadius: 0, color: colorShadow, offset: Offset(0, 2))]),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        margin: EdgeInsetsDirectional.only(top: 20.h),
        child: Row(
          children: [
            Expanded(child: Text("${language.card} xxxx xxxx xxxx 1111", style: bodyTextStyle())),
            CustomRadio(selected: paymentType == PaymentType.card),
          ],
        ),
      ),
    );
  }

  Widget _placeOrderButton(int paymentType, num walletAmount) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(color: colorWhite, boxShadow: [BoxShadow(color: colorShadow, blurRadius: 5, spreadRadius: 5, offset: Offset(0, 5))]),
        child: Row(
          children: [
            Expanded(child: Text(widget.orderAmount.withCurrency, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp))),
            CustomButton(
              title: language.payNow,
              height: 30.h,
              fontSize: 14.sp,
              onPress: () async {
                ref.read(makePaymentPro((paymentType: paymentType, orderAmount: widget.orderAmount, walletAmount: walletAmount)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
