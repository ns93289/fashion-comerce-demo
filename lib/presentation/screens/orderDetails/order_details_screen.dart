import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/extensions.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/text_utils.dart';
import '../../../core/utils/time_utils.dart';
import '../../../core/utils/tools.dart';
import '../../../data/models/model_key_value.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../domain/entities/cart_preview_entity.dart';
import '../../../domain/entities/order_details_entity.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/empty_record_view.dart';
import '../../components/item_key_value.dart';
import '../../provider/order_details_provider.dart';
import '../cart/item_cart_data.dart';
import '../home/home_screen.dart';
import 'order_details_shimmer.dart';
import 'order_status_view.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final _titleStyle = bodyTextStyle(fontWeight: FontWeight.w600);

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
      child: Scaffold(appBar: CommonAppBar(leading: BackButton(), title: Text(language.orderDetails)), body: SafeArea(child: _buildOrderDetails())),
    );
  }

  Widget _buildOrderDetails() {
    return Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(orderDetailsServiceProvider(widget.orderId));

        return result.when(
          data: (data) {
            if (data != null) {
              return SingleChildScrollView(
                padding: EdgeInsetsDirectional.only(bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _orderId(data.orderId.toString(), data.orderDate),
                    _commonDiver(),
                    _orderedProducts(data.products),
                    _commonDiver(),
                    _statusView(data),
                    _commonDiver(),
                    _deliveryAddress(data.address),
                    _commonDiver(),
                    _deliveryOptions(),
                    _commonDiver(),
                    _invoiceDetails(data),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
          error: (error, stackTrace) => EmptyRecordView(message: error.toString()),
          loading: () => OrderDetailsShimmer(),
        );
      },
    );
  }

  Widget _orderId(String orderNo, String orderTime) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 10.h, start: 20.w, end: 20.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(language.orderNumber, style: bodyTextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                SizedBox(height: 5.h),
                Text(orderNo, style: bodyTextStyle(fontSize: 12.sp)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(language.orderPlaced, style: bodyTextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
              SizedBox(height: 5.h),
              Text(TimeUtils.getFormatedDate(orderTime, returnFormat: "dd MMM yyyy"), style: bodyTextStyle(fontSize: 12.sp)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _orderedProducts(List<CartProductEntity> productList) {
    return ListView.separated(
      itemCount: productList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
      itemBuilder: (context, index) {
        return ItemCartData(item: productList[index], allowEdit: false);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(padding: EdgeInsets.symmetric(vertical: 10.h), child: Divider(height: 0, thickness: 1.sp, color: colorMainBackground));
      },
    );
  }

  Widget _deliveryAddress(AddressEntity address) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language.deliverTo, style: _titleStyle),
          SizedBox(height: 10.h),
          Text(language.home, style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 10.h),
          Text(TextUtils.getFullAddress(address), style: bodyTextStyle(fontSize: 14.sp)),
        ],
      ),
    );
  }

  Widget _deliveryOptions() {
    return Consumer(
      builder: (context, ref, child) {
        return Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(language.deliveryType, style: _titleStyle),
              SizedBox(height: 10.h),
              Text(language.fastDelivery, style: bodyTextStyle(fontSize: 14.sp)),
            ],
          ),
        );
      },
    );
  }

  Widget _statusView(OrderDetailsEntity data) {
    final OrderDetailsEntity(:orderStatus, :orderDate) = data;

    return Consumer(
      builder: (context, ref, _) {
        return Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
          child: OrderStatusView(
            orderStatus: orderStatus,
            orderTime: orderDate,
            cancelledBy: "cancelledBy",
            onViewStatusClick: () {
              ref.read(openProductStatusBSProvider((orderDetails: data, context: context)));
            },
          ),
        );
      },
    );
  }

  Widget _invoiceDetails(OrderDetailsEntity data) {
    List<ModelKeyValue> invoiceList = [
      ModelKeyValue("${language.subTotal}-", data.subTotal.withCurrency),
      ModelKeyValue("${language.total}-", data.totalAmount.withCurrency, setBold: true, setDivider: true),
    ];

    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language.cartDetails, style: _titleStyle),
          ListView.builder(
            itemCount: invoiceList.length,
            shrinkWrap: true,
            padding: EdgeInsetsDirectional.only(top: 5.h),
            itemBuilder: (context, index) {
              return ItemKeyValue(modelKeyValue: invoiceList[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _commonDiver() {
    return Padding(padding: EdgeInsetsDirectional.symmetric(vertical: 15.h, horizontal: 20.w), child: Divider(height: 0, thickness: 1.sp, color: colorBorder));
  }
}
