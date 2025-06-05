import 'package:expandable_richtext/expandable_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants/extensions.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/tools.dart';
import '../../../domain/entities/product_entity.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_button.dart';
import '../../provider/cart_data_provider.dart';
import '../../provider/product_details_provider.dart';
import '../../../data/dataSources/local/hive_helper.dart';
import '../../../main.dart';
import '../cart/cart_screen.dart';
import 'views/product_images_view.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  final String productName;

  const ProductDetailsScreen({super.key, required this.productId, required this.productName});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _specStyle = bodyTextStyle(fontWeight: FontWeight.w500);
  final _specValueStyle = bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: Text(widget.productName),
        centerTitle: true,
        actions: [
          _favoriteButton(),
          ValueListenableBuilder(
            valueListenable: cartBox.listenable(),
            builder: (context, value, child) {
              final cartData = getCartDataFromCartBox();
              return cartData.isEmpty ? Container() : _cartView(cartData);
            },
          ),
        ],
      ),
      body: SafeArea(child: _buildProductDetails()),
    );
  }

  Widget _buildProductDetails() {
    return Consumer(
      builder: (context, ref, child) {
        final data = ref.watch(productDetailsProvider(widget.productId));

        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsetsDirectional.only(bottom: 80.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _productImagesView(data),
                  _productPriceAndDiscount(data),
                  _productDescription(data.productDescription),
                  _productSizes(data.productSizes),
                  _productColors(data.productColors),
                  // _productQuantity(data.productQuantities),
                  _productSpecifications(data),
                  _deliveryOptions(data),
                ],
              ),
            ),
            Align(alignment: Alignment.bottomCenter, child: _actionButtons()),
          ],
        );
      },
    );
  }

  Widget _productImagesView(ProductEntity data) {
    return ProductImagesView(imageList: [data.productImage, data.productImage, data.productImage]);
  }

  Widget _productPriceAndDiscount(ProductEntity data) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20.w, top: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.productPrice.withCurrency, style: bodyTextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Text(data.productDiscount.withCurrency, style: bodyTextStyle(color: colorRed, fontSize: 14.sp, decoration: TextDecoration.lineThrough)),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 5.w),
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 5.w, vertical: 1.h),
                    decoration: BoxDecoration(color: colorDiscount, borderRadius: BorderRadius.circular(5.r)),
                    child: Text("-${data.discountType}%", style: bodyTextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 14.sp)),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.timer_outlined, color: colorPrimary, size: 20.sp),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  margin: EdgeInsetsDirectional.only(start: 5.w, end: 5.w),
                  decoration: BoxDecoration(color: colorDivider, borderRadius: BorderRadius.circular(5.r)),
                  child: Text("00", style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  decoration: BoxDecoration(color: colorDivider, borderRadius: BorderRadius.circular(5.r)),
                  child: Text("00", style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  margin: EdgeInsetsDirectional.only(start: 5.w, end: 5.w),
                  decoration: BoxDecoration(color: colorDivider, borderRadius: BorderRadius.circular(5.r)),
                  child: Text("00", style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                ),
                Container(
                  padding: EdgeInsets.all(5.sp),
                  margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
                  decoration: BoxDecoration(color: colorDivider, shape: BoxShape.circle),
                  child: Icon(Icons.share, size: 15.sp, color: colorTextLight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _productDescription(String productDescription) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
      child: ExpandableRichText(
        productDescription,
        expandText: language.more,
        collapseText: language.less,
        maxLines: 2,
        style: bodyTextStyle(fontSize: 14.sp),
        toggleTextStyle: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: colorPrimary),
      ),
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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: 5.w),
                      child: Text(language.sizeGuide, style: bodyTextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Container(
                    height: 30.sp,
                    width: 30.sp,
                    margin: EdgeInsetsDirectional.only(end: 20.w),
                    decoration: BoxDecoration(color: colorPrimary, shape: BoxShape.circle),
                    child: Icon(Icons.arrow_forward, color: colorText, size: 15.sp),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 5.w, bottom: 5.h, top: 5.h),
                child: Text(language.size, style: bodyTextStyle(fontWeight: FontWeight.w500)),
              ),
              Row(
                children:
                    productSizes.map((e) {
                      return GestureDetector(
                        onTap: () {
                          ref.read(productSizeProvider.notifier).state = e;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedSize == e ? colorPrimary.withAlpha(10) : colorDivider,
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(color: selectedSize == e ? colorPrimary : Colors.transparent, width: 1.sp),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          height: 25.h,
                          child: Center(child: Text(e.toString(), style: _specValueStyle)),
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

  Widget _productColors(List<String> productColors) {
    return Consumer(
      builder: (context, ref, _) {
        final selectedColor = ref.watch(productColorProvider);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 20.w, top: 20.h),
              child: Text(language.colors, style: bodyTextStyle(fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 60.sp,
              child: ListView.builder(
                itemCount: productColors.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsetsDirectional.only(start: 20.w, top: 10.h),
                itemBuilder: (context, index) {
                  bool selected = index == selectedColor;
                  String color = productColors[index];
                  return GestureDetector(
                    onTap: () {
                      ref.read(productColorProvider.notifier).state = index;
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colorWhite,
                            shape: BoxShape.circle,
                            border: Border.all(color: selected ? colorPrimary : colorWhite),
                            boxShadow: [BoxShadow(color: colorShadow, blurRadius: 10, spreadRadius: 0, offset: Offset(0, 5))],
                          ),
                          margin: EdgeInsetsDirectional.only(end: 20.w),
                          padding: EdgeInsets.all(5.sp),
                          height: 40.sp,
                          width: 40.sp,
                          child: Container(decoration: BoxDecoration(color: color.hexToColor, shape: BoxShape.circle)),
                        ),
                        if (selected)
                          Container(
                            decoration: BoxDecoration(
                              color: colorWhite,
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: colorShadow, blurRadius: 10, spreadRadius: 0, offset: Offset(0, 5))],
                            ),
                            margin: EdgeInsetsDirectional.only(start: 25.sp, top: 2.h),
                            padding: EdgeInsets.all(2.sp),
                            height: 22.sp,
                            width: 22.sp,
                            child: Container(
                              decoration: BoxDecoration(shape: BoxShape.circle, color: colorPrimary),
                              padding: EdgeInsets.all(1.sp),
                              child: Icon(Icons.check_sharp, size: 10.sp),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // Widget _productQuantity(List<int> productQuantities) {
  //   return Consumer(
  //     builder: (context, ref, child) {
  //       final selectedQuantity = ref.watch(productQuantityProvider);
  //
  //       return Padding(
  //         padding: EdgeInsetsDirectional.only(start: 20.w, top: 20.h),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Padding(padding: EdgeInsetsDirectional.only(end: 5.w), child: Text("${language.quantity}:", style: bodyTextStyle(fontSize: 14.sp))),
  //             Container(
  //               decoration: BoxDecoration(border: Border.all(color: colorTextLight), borderRadius: BorderRadius.circular(5.r)),
  //               padding: EdgeInsetsDirectional.only(start: 10.w),
  //               child: DropdownButton<int>(
  //                 isDense: true,
  //                 items:
  //                     productQuantities.map((e) {
  //                       return DropdownMenuItem(value: e, child: Text(e.toString(), style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)));
  //                     }).toList(),
  //                 value: selectedQuantity,
  //                 onChanged: (value) {
  //                   ref.read(productQuantityProvider.notifier).state = value ?? 0;
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _productSpecifications(ProductEntity data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, top: 20.h),
          child: Text(language.specifications, style: bodyTextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        ),
        Padding(padding: EdgeInsetsDirectional.only(start: 20.w, top: 10.h), child: Text(language.design, style: _specStyle)),
        Container(
          decoration: BoxDecoration(color: colorDivider, borderRadius: BorderRadius.circular(5.r)),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          margin: EdgeInsetsDirectional.only(start: 20.w, top: 5.h),
          child: Text(data.productDesign, style: _specValueStyle),
        ),
        Padding(padding: EdgeInsetsDirectional.only(start: 20.w, top: 10.h), child: Text(language.material, style: _specStyle)),
        Container(
          decoration: BoxDecoration(color: colorDivider, borderRadius: BorderRadius.circular(5.r)),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          margin: EdgeInsetsDirectional.only(start: 20.w, top: 5.h),
          child: Text(data.productMaterial, style: _specValueStyle),
        ),
        Padding(padding: EdgeInsetsDirectional.only(start: 20.w, top: 10.h), child: Text(language.origin, style: _specStyle)),
        Container(
          decoration: BoxDecoration(color: colorDivider, borderRadius: BorderRadius.circular(5.r)),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          margin: EdgeInsetsDirectional.only(start: 20.w, top: 5.h, bottom: 10.h),
          child: Text(data.productCountry, style: _specValueStyle),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 20.w),
                child: Text(language.caringGuide, style: bodyTextStyle(fontWeight: FontWeight.w500)),
              ),
            ),
            Container(
              height: 30.sp,
              width: 30.sp,
              margin: EdgeInsetsDirectional.only(end: 20.w),
              decoration: BoxDecoration(color: colorPrimary, shape: BoxShape.circle),
              child: Icon(Icons.arrow_forward, color: colorText, size: 15.sp),
            ),
          ],
        ),
      ],
    );
  }

  Widget _deliveryOptions(ProductEntity data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
          child: Text(language.delivery, style: bodyTextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), border: Border.all(color: colorPrimary)),
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 10.h),
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 10.h),
          child: Row(
            children: [
              Text(language.standard, style: _specStyle),
              Expanded(child: Center(child: Text("5-7 days", style: bodyTextStyle(fontSize: 14.sp, color: colorTextLight)))),
              Text(data.deliveryCharge.withCurrency, style: bodyTextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), border: Border.all(color: colorPrimary)),
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 10.h),
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 10.h),
          child: Row(
            children: [
              Text(language.express, style: _specStyle),
              Expanded(child: Center(child: Text("1-2 days", style: bodyTextStyle(fontSize: 14.sp, color: colorTextLight)))),
              Text(data.deliveryCharge.withCurrency, style: bodyTextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionButtons() {
    return Consumer(
      builder: (context,ref,_) {
        final data = ref.watch(productDetailsProvider(widget.productId));

        final selectedSize = ref.watch(productSizeProvider);
        final selectedQuantity = ref.watch(productQuantityProvider);

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(color: colorWhite, boxShadow: [BoxShadow(color: colorShadow, blurRadius: 5, spreadRadius: 0, offset: Offset(0, -5))]),
          child: Row(
            children: [
              Expanded(child: CustomButton(onPress: () async {
                data.selectedSize = selectedSize;
                data.selectedQuantity = selectedQuantity;
                await putDataIntoCartBox(data);
                ref.read(checkoutInvoiceProvider);
                ref.read(checkoutDataProvider);
              },title: language.addToCart, backgroundColor: colorBlack, textColor: colorPrimary)),
              SizedBox(width: 20.w),
              Expanded(child: CustomButton(title: language.buyNow)),
            ],
          ),
        );
      }
    );
  }

  Widget _cartView(List<ProductEntity> cartData) {
    return GestureDetector(
      onTap: () {
        openScreen(context, CartScreen());
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(end: 10.w),
        child: Stack(
          children: [
            Icon(Icons.shopping_bag_outlined, color: colorBlack),
            Container(
              margin: EdgeInsetsDirectional.only(start: 11.w),
              decoration: BoxDecoration(shape: BoxShape.circle, color: colorPrimary),
              padding: EdgeInsets.all(4.sp),
              child: Text(cartData.length.toString(), style: bodyTextStyle(fontSize: 10.sp)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _favoriteButton() {
    return Padding(padding: EdgeInsetsDirectional.only(end: 10.w), child: Icon(Icons.favorite_outline, color: colorBlack));
  }
}
