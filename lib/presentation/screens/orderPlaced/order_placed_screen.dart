import 'package:fashion_comerce_demo/presentation/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Scaffold(appBar: CommonAppBar(title: Text(language.orderPlaced)), body: _buildOrderPlaced());
  }

  Widget _buildOrderPlaced() {
    return Column(
      children: [
        _orderSuccessCard(),
        Text("${language.orderPlacedMsg} ${widget.orderNo}", style: bodyTextStyle()),
        CustomButton(
          title: language.viewOrder,
          onPress: () {
            openScreen(context, OrderDetailsScreen(orderId: widget.orderId));
          },
        ),
      ],
    );
  }

  Widget _orderSuccessCard() {
    return Container(
      decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(10.r)),
      margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
      padding: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          Icon(Icons.check_circle, color: colorGreen),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Text(language.orderPlacedSuccess, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp)),
          ),
        ],
      ),
    );
  }
}
