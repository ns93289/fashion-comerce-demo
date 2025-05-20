import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../data/dataSources/remote/api_reponse.dart';
import '../../../data/models/model_order_details.dart';
import '../../../data/models/model_product.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/empty_record_view.dart';
import '../../provider/order_details_provider.dart';
import '../home/home_screen.dart';
import 'item_ordered.dart';
import 'order_details_shimmer.dart';
import 'order_status_view.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          openScreenWithClearStack(context, HomeScreen());
        }
      },
      child: Scaffold(appBar: CommonAppBar(leading: BackButton(), title: Text(language.orderDetails)), body: _buildOrderDetails()),
    );
  }

  Widget _buildOrderDetails() {
    return Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(orderDetailsFP(widget.orderId));

        return result.when(
          data: (apiResult) {
            if (apiResult is ApiSuccess) {
              ModelOrderDetails data = (apiResult as ApiSuccess).data;

              return SingleChildScrollView(
                padding: EdgeInsetsDirectional.only(bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _orderId(data.orderNo),
                    _commonDiver(),
                    _orderedProducts(data.orderedProducts),
                    _commonDiver(),
                    _addressDetails(data.deliveryAddress),
                    _commonDiver(),
                    _statusView(data),
                  ],
                ),
              );
            } else {
              String message = (apiResult as ApiError).errorData.message;
              return EmptyRecordView(message: message);
            }
          },
          error: (error, stackTrace) => EmptyRecordView(message: error.toString()),
          loading: () => OrderDetailsShimmer(),
        );
      },
    );
  }

  Widget _orderId(String orderNo) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w),
      child: Text("${language.orderId}: $orderNo", style: bodyTextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _orderedProducts(List<ModelProduct> productList) {
    return ListView.separated(
      itemCount: productList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
      itemBuilder: (context, index) {
        return ItemOrdered(orderedProducts: productList[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(padding: EdgeInsets.symmetric(vertical: 10.h), child: Divider(height: 0, thickness: 1.sp, color: colorMainBackground));
      },
    );
  }

  Widget _addressDetails(String deliveryAddress) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language.deliverTo, style: bodyTextStyle(fontSize: 14.sp)),
          SizedBox(height: 5.h),
          Text(deliveryAddress, style: bodyTextStyle(fontSize: 14.sp, color: colorTextLight)),
        ],
      ),
    );
  }

  Widget _statusView(ModelOrderDetails data) {
    final ModelOrderDetails(:orderStatus, :deliveryTime, :packedTime, :shippedTime, :cancelledBy, :orderTime) = data;

    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
      child: OrderStatusView(
        orderStatus: orderStatus,
        deliveryTime: deliveryTime,
        orderTime: orderTime,
        packedTime: packedTime,
        shippedTime: shippedTime,
        cancelledBy: cancelledBy,
      ),
    );
  }

  Widget _commonDiver() {
    return Padding(padding: EdgeInsetsDirectional.symmetric(vertical: 10.h), child: Divider(height: 0, thickness: 1.sp, color: colorMainBackground));
  }
}
