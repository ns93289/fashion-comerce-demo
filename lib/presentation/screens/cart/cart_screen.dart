import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/tools.dart';
import '../../provider/cart_data_provider.dart';
import '../../components/custom_button.dart';
import '../../../core/constants/colors.dart';
import '../../components/empty_record_view.dart';
import '../../components/common_app_bar.dart';
import '../../../data/dataSources/local/hive_helper.dart';
import '../../../main.dart';
import '../../components/item_key_value.dart';
import '../../../data/models/model_product.dart';
import '../payment/payment_screen.dart';
import 'item_cart_data.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  final _titleStyle = bodyTextStyle(fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.yourCart)), body: SafeArea(child: _buildCartScreen()));
  }

  Widget _buildCartScreen() {
    return ValueListenableBuilder(
      valueListenable: cartBox.listenable(),
      builder: (context, box, _) {
        List<ModelProduct> cartData = getCartDataFromCartBox();
        return cartData.isEmpty
            ? EmptyRecordView(message: language.emptyCartMsg)
            : Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsetsDirectional.only(bottom: 50.h),
                  child: Column(
                    children: [_cartData(cartData), _commonDiver(), _deliveryAddress(), _commonDiver(), _deliveryOptions(), _commonDiver(), _invoiceDetails()],
                  ),
                ),
                _placeOrderButton(),
              ],
            );
      },
    );
  }

  Widget _cartData(List<ModelProduct> cartData) {
    return ListView.separated(
      itemCount: cartData.length,
      shrinkWrap: true,
      padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 10.h),
      itemBuilder: (context, index) {
        return ItemCartData(item: cartData[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(padding: EdgeInsetsDirectional.symmetric(vertical: 10.h));
      },
    );
  }

  Widget _deliveryAddress() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(language.deliverTo, style: _titleStyle)),
                    CustomButton(
                      title: language.change,
                      height: 25.h,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      onPress: () {},
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(language.home, style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 10.h),
                Text("101, ABC Complex, XYZ Place, ASD, 100001, Delhi, India", style: bodyTextStyle(fontSize: 14.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _deliveryOptions() {
    return Consumer(
      builder: (context, ref, child) {
        final deliveryType = ref.watch(deliveryTypeProvider);

        return Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(language.deliveryType, style: _titleStyle),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  ref.read(deliveryTypeProvider.notifier).state = DeliveryTypes.fast;
                },
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 12.sp, color: deliveryType == DeliveryTypes.fast ? colorPrimary : colorCategoryBackground),
                    SizedBox(width: 10.w),
                    Expanded(child: Text(language.fastDelivery, style: bodyTextStyle(fontSize: 14.sp))),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  ref.read(deliveryTypeProvider.notifier).state = DeliveryTypes.express;
                },
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 12.sp, color: deliveryType == DeliveryTypes.express ? colorPrimary : colorCategoryBackground),
                    SizedBox(width: 10.w),
                    Expanded(child: Text(language.expressDelivery, style: bodyTextStyle(fontSize: 14.sp))),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  ref.read(deliveryTypeProvider.notifier).state = DeliveryTypes.standard;
                },
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 12.sp, color: deliveryType == DeliveryTypes.standard ? colorPrimary : colorCategoryBackground),
                    SizedBox(width: 10.w),
                    Expanded(child: Text(language.freeDelivery, style: bodyTextStyle(fontSize: 14.sp))),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _invoiceDetails() {
    final data = ref.watch(checkoutInvoiceProvider);
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language.cartDetails, style: _titleStyle),
          ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            padding: EdgeInsetsDirectional.only(top: 5.h),
            itemBuilder: (context, index) {
              return ItemKeyValue(modelKeyValue: data[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _placeOrderButton() {
    final data = ref.watch(checkoutDataProvider);
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomButton(
        title: language.proceedToPay,
        margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, bottom: 20.h),
        width: 1.sw,
        onPress: () {
          openScreen(context, PaymentScreen(orderAmount: data));
        },
      ),
    );
  }

  Widget _commonDiver() {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 15.h, horizontal: 20.w),
      child: Divider(height: 0, thickness: 1.sp, color: colorMainBackground),
    );
  }
}
