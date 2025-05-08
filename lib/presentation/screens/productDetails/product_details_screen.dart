import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../domain/provider/product_details_provider.dart';
import '../../components/custom_button.dart';
import '../../../data/dataSources/local/hive_helper.dart';
import '../../../main.dart';
import '../../../data/models/model_product.dart';
import '../cart/cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildProductDetails()));
  }

  Widget _buildProductDetails() {
    return Consumer(
      builder: (context, ref, child) {
        final data = ref.watch(productDetailsProvider(widget.productId));

        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsetsDirectional.only(bottom: 20.h),
              child: Column(
                children: [
                  _productView(data),
                  _productSizes(data.productSizes),
                  _productQuantity(data.productQuantities),
                  _productSpecifications(data),
                  _productPrice(data),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: cartBox.listenable(),
              builder: (context, value, child) {
                final cartData = getCartDataFromCartBox();
                return cartData.isEmpty ? Container() : _cartView(cartData);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _productView(ModelProduct data) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: Container(
                height: 300.h,
                decoration: BoxDecoration(color: colorBlack, borderRadius: BorderRadiusDirectional.only(bottomStart: Radius.circular(10.r))),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BackButton(),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 20.w),
                    child: Text(data.productName, style: bodyTextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp)),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 10.h, start: 20.w),
                    child: Text(data.productDescription, style: bodyTextStyle(fontSize: 14.sp)),
                  ),
                ],
              ),
            ),
            Expanded(flex: 2, child: Image.asset(data.productImage)),
          ],
        ),
      ],
    );
  }

  Widget _productSizes(List<num> productSizes) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedSize = ref.watch(productSizeProvider);

        return Padding(
          padding: EdgeInsetsDirectional.only(start: 15.w, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsetsDirectional.only(start: 5.w, bottom: 5.h), child: Text(language.selectSize, style: bodyTextStyle(fontSize: 14.sp))),
              Row(
                children:
                    productSizes.map((e) {
                      return GestureDetector(
                        onTap: () {
                          ref.read(productSizeProvider.notifier).state = e;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedSize == e ? colorBlack : colorWhite,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: selectedSize == e ? Colors.transparent : colorBlack, width: 1.sp),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          width: 25.w,
                          height: 30.h,
                          child: Center(
                            child: Text(
                              e.toString(),
                              style: bodyTextStyle(color: selectedSize == e ? colorWhite : colorText, fontWeight: FontWeight.w500, fontSize: 14.sp),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _productQuantity(List<int> productQuantities) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedQuantity = ref.watch(productQuantityProvider);

        return Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, top: 20.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsetsDirectional.only(end: 5.w), child: Text("${language.quantity}:", style: bodyTextStyle(fontSize: 14.sp))),
              Container(
                decoration: BoxDecoration(border: Border.all(color: colorTextLight), borderRadius: BorderRadius.circular(5.r)),
                padding: EdgeInsetsDirectional.only(start: 10.w),
                child: DropdownButton<int>(
                  isDense: true,
                  items:
                      productQuantities.map((e) {
                        return DropdownMenuItem(value: e, child: Text(e.toString(), style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)));
                      }).toList(),
                  value: selectedQuantity,
                  onChanged: (value) {
                    ref.read(productQuantityProvider.notifier).state = value ?? 0;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _productSpecifications(ModelProduct data) {
    final specStyle = bodyTextStyle(fontSize: 14.sp);
    final specValueStyle = bodyTextStyle(fontSize: 14.sp, color: colorTextLight);

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Padding(padding: EdgeInsetsDirectional.only(start: 5.w), child: Text(language.specifications, style: bodyTextStyle())),
        childrenPadding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: colorTabDivider, width: 1.sp)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(border: BorderDirectional(end: BorderSide(color: colorTabDivider, width: 1.w))),
                    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                    child: Text(language.design, style: specStyle),
                  ),
                ),
                Expanded(child: Center(child: Text(data.productDesign, style: specValueStyle))),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: colorTabDivider, width: 1.sp)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(border: BorderDirectional(end: BorderSide(color: colorTabDivider, width: 1.w))),
                    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                    child: Text(language.care, style: specStyle),
                  ),
                ),
                Expanded(child: Center(child: Text(data.productCare, style: specValueStyle))),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: colorTabDivider, width: 1.sp)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(border: BorderDirectional(end: BorderSide(color: colorTabDivider, width: 1.w))),
                    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                    child: Text(language.material, style: specStyle),
                  ),
                ),
                Expanded(child: Center(child: Text(data.productMaterial, style: specValueStyle))),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: colorTabDivider, width: 1.sp)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(border: BorderDirectional(end: BorderSide(color: colorTabDivider, width: 1.w))),
                    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                    child: Text(language.country, style: specStyle),
                  ),
                ),
                Expanded(child: Center(child: Text(data.productCountry, style: specValueStyle))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _productPrice(ModelProduct data) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedSize = ref.watch(productSizeProvider);
        final selectedQuantity = ref.watch(productQuantityProvider);

        return Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(language.totalPrice, style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                    Text(data.productPrice.withCurrency, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp)),
                  ],
                ),
              ),
              CustomButton(
                title: language.addToCart,
                onPress: () {
                  if (selectedSize == 0) {
                    openSimpleSnackBar(language.selectSize);
                  } else {
                    data.selectedSize = selectedSize;
                    data.selectedQuantity = selectedQuantity;
                    putDataIntoCartBox(data);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _cartView(List<ModelProduct> cartData) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          openScreen(context, CartScreen());
        },
        child: Container(
          width: 50.sp,
          height: 50.sp,
          margin: EdgeInsetsDirectional.only(bottom: 20.h),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(color: colorWhite, shape: BoxShape.circle, boxShadow: [BoxShadow(blurRadius: 5, spreadRadius: 5, color: colorShadow)]),
          child: Stack(
            children: [
              Padding(padding: EdgeInsetsDirectional.only(top: 12.h), child: Icon(Icons.shopping_cart_outlined, color: colorBlack, size: 25.sp)),
              Container(
                margin: EdgeInsetsDirectional.only(start: 12.5.w, top: 2.5.h),
                decoration: BoxDecoration(shape: BoxShape.circle, color: colorPrimary),
                padding: EdgeInsets.all(4.sp),
                child: Text(cartData.length.toString(), style: bodyTextStyle(fontSize: 12.sp)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
