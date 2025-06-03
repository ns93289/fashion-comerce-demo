import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/theme.dart';
import '../../components/custom_button.dart';
import '../home/home_screen.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../orderDetails/order_details_screen.dart';

class OrderPlacedScreen extends StatefulWidget {
  final int orderId;
  final String orderNo;

  const OrderPlacedScreen({super.key, required this.orderId, required this.orderNo});

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        openScreenWithClearStack(context, HomeScreen());
      },
      child: Scaffold(appBar: CommonAppBar(leading: BackButton(), title: Text(language.orderPlaced)), body: _buildOrderPlaced()),
    );
  }

  Widget _buildOrderPlaced() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _orderSuccessCard(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
          child: Text("${language.orderPlacedMsg} ${widget.orderNo}", style: bodyTextStyle()),
        ),
        CustomButton(
          title: language.viewOrder,
          onPress: () {
            openScreenWithClearStack(context, OrderDetailsScreen(orderId: widget.orderId));
          },
        ),
      ],
    );
  }

  Widget _orderSuccessCard() {
    return Container(
      decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(10.r)),
      margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          Icon(Icons.check_circle, color: colorGreen, size: 30.sp),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Text(language.orderPlacedSuccess, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp)),
          ),
        ],
      ),
    );
  }
}
