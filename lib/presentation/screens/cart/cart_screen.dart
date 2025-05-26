import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../core/constants/extensions.dart';
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
                    children: [
                      _deliveryAddress(),
                      _commonDiver(),
                      _cartData(cartData),
                      Padding(padding: EdgeInsets.only(top: 10.h), child: _commonDiver()),
                      _invoiceDetails(),
                    ],
                  ),
                ),
                _placeOrderButton(),
              ],
            );
      },
    );
  }

  Widget _deliveryAddress() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsetsDirectional.only(end: 5.w), child: Text("${language.deliverTo}:", style: bodyStyle(fontSize: 14.sp))),
                    Expanded(child: Text(language.home, style: bodyStyle(fontSize: 14.sp))),
                  ],
                ),
                Text("101, ABC Complex, XYZ Place, ASD, 100001, Delhi, India", style: bodyStyle(fontSize: 14.sp, color: colorTextLight)),
              ],
            ),
          ),
          Icon(Icons.edit_outlined, color: colorTextLight, size: 20.sp),
        ],
      ),
    );
  }

  Widget _cartData(List<ModelProduct> cartData) {
    return ListView.separated(
      itemCount: cartData.length,
      shrinkWrap: true,
      padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
      itemBuilder: (context, index) {
        return ItemCartData(item: cartData[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(padding: EdgeInsetsDirectional.symmetric(vertical: 10.h), child: Divider(height: 0, thickness: 1.sp, color: colorMainBackground));
      },
    );
  }

  Widget _invoiceDetails() {
    final data = ref.watch(checkoutInvoiceProvider);
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 10.h, start: 20.w, end: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language.invoice, style: bodyStyle(fontWeight: FontWeight.w500)),
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(color: colorWhite, boxShadow: [BoxShadow(color: colorShadow, blurRadius: 5, spreadRadius: 5, offset: Offset(0, 5))]),
        child: Row(
          children: [
            Expanded(child: Text(data.withCurrency, style: bodyStyle(fontWeight: FontWeight.bold, fontSize: 20.sp))),
            CustomButton(
              title: language.placeOrder,
              height: 30.h,
              fontSize: 14.sp,
              onPress: () {
                openScreen(context, PaymentScreen(orderAmount: data));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _commonDiver() {
    return Padding(padding: EdgeInsetsDirectional.symmetric(vertical: 10.h), child: Divider(height: 0, thickness: 1.sp, color: colorMainBackground));
  }
}
