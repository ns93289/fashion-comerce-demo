import 'package:expandable_richtext/expandable_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/dataSources/local/hive_constants.dart';
import '../../components/common_circle_progress_bar.dart';
import '../../components/empty_record_view.dart';
import '../../../core/constants/extensions.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/text_utils.dart';
import '../../../domain/entities/product_details_entity.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_button.dart';
import '../../provider/home_provider.dart';
import '../../provider/navigation_provider.dart';
import '../../provider/product_details_provider.dart';
import '../../../data/dataSources/local/hive_helper.dart';
import '../../../main.dart';
import '../cart/cart_screen.dart';
import 'views/product_images_view.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  final String? size;
  final String? color;
  final String productName;

  const ProductDetailsScreen({super.key, required this.productId, required this.productName, this.size, this.color});

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
              final cartData = getCartCountFromCartBox();
              return cartData == 0 ? Container() : _cartView(cartData);
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
        final response = ref.watch(productDetailsServiceProvider((id: widget.productId, size: widget.size, color: widget.color)));
        final _ = ref.watch(offerTimerProvider);

        return response?.when(
              data: (data) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsetsDirectional.only(bottom: 80.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _productImagesView(data),
                          _productPriceAndDiscount(data),
                          _productDescription(data.description),
                          _productSizes(data.uniqueSizes, data.uniqueColors),
                          _productColors(data.uniqueColors, data.uniqueSizes),
                          // _productQuantity(data.productQuantities),
                          _productSpecifications(data),
                          _deliveryOptions(data),
                        ],
                      ),
                    ),
                    Align(alignment: Alignment.bottomCenter, child: _actionButtons(data)),
                  ],
                );
              },
              error: (error, stackTrace) => EmptyRecordView(message: error.toString()),
              loading: () => CommonCircleProgressBar(),
            ) ??
            Container();
      },
    );
  }

  Widget _productImagesView(ProductDetailsEntity data) {
    return ProductImagesView(imageList: data.images);
  }

  Widget _productPriceAndDiscount(ProductDetailsEntity data) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20.w, top: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.price.withCurrency, style: bodyTextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 5.h),
              if (data.discountType > 0)
                Row(
                  children: [
                    Text(data.discountPrice.withCurrency, style: bodyTextStyle(color: colorRed, fontSize: 14.sp, decoration: TextDecoration.lineThrough)),
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 5.w),
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 5.w, vertical: 1.h),
                      decoration: BoxDecoration(color: colorDiscount, borderRadius: BorderRadius.circular(5.r)),
                      child: Text(
                        "-${TextUtils.getDiscountString(data.discountType, data.discountValue)}",
                        style: bodyTextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          if (data.discountType > 0)
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  final remainingTime = ref.watch(offerRemainingTimeProvider);
                  final duration = Duration(seconds: remainingTime);
                  final hours = duration.inHours.toString().padLeft(2, '0');
                  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
                  final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.timer_outlined, color: colorPrimary, size: 20.sp),
                      Container(
                        height: 27.sp,
                        width: 30.sp,
                        alignment: Alignment.center,
                        margin: EdgeInsetsDirectional.only(start: 5.w, end: 5.w),
                        decoration: BoxDecoration(color: colorDivider, borderRadius: BorderRadius.circular(5.r)),
                        child: Text(hours, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                      ),
                      Container(
                        height: 27.sp,
                        width: 30.sp,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: colorDivider, borderRadius: BorderRadius.circular(5.r)),
                        child: Text(minutes, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                      ),
                      Container(
                        height: 27.sp,
                        width: 30.sp,
                        alignment: Alignment.center,
                        margin: EdgeInsetsDirectional.only(start: 5.w, end: 5.w),
                        decoration: BoxDecoration(color: colorDivider, borderRadius: BorderRadius.circular(5.r)),
                        child: Text(secs, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
                      ),
                      Container(
                        padding: EdgeInsets.all(5.sp),
                        margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
                        decoration: BoxDecoration(color: colorDivider, shape: BoxShape.circle),
                        child: Icon(Icons.share, size: 15.sp, color: colorTextLight),
                      ),
                    ],
                  );
                },
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

  Widget _productSizes(List<String> productSizes, List<String> productColors) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedSize = ref.watch(productSizeProvider);
        final selectedColor = productColors[ref.watch(productColorProvider)];

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
              SizedBox(
                height: 25.h,
                child: ListView.builder(
                  itemCount: productSizes.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ref.read(productSizeProvider.notifier).state = index;
                        ref.read(productDetailsServiceProvider((id: widget.productId, size: productSizes[index], color: selectedColor)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedSize == index ? colorPrimary.withAlpha(10) : colorDivider,
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(color: selectedSize == index ? colorPrimary : Colors.transparent, width: 1.sp),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        height: 25.h,
                        child: Center(child: Text(productSizes[index].toString(), style: _specValueStyle)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _productColors(List<String> productColors, List<String> productSizes) {
    return Consumer(
      builder: (context, ref, _) {
        final selectedColor = ref.watch(productColorProvider);
        final selectedSize = productSizes[ref.watch(productSizeProvider)];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 20.w, top: 20.h, bottom: 10.h),
              child: Text(language.colors, style: bodyTextStyle(fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 80.sp,
              child: ListView.builder(
                itemCount: productColors.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsetsDirectional.only(start: 20.w),
                itemBuilder: (context, index) {
                  bool selected = index == selectedColor;
                  String color = productColors[index];
                  return GestureDetector(
                    onTap: () {
                      ref.read(productColorProvider.notifier).state = index;
                      ref.read(productDetailsServiceProvider((id: widget.productId, size: selectedSize, color: productColors[index])));
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(end: 15.w),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: colorWhite, border: Border.all(color: selected ? colorPrimary : colorWhite)),
                            padding: EdgeInsets.all(5.sp),
                            height: 60.sp,
                            width: 60.sp,
                            child: Container(decoration: BoxDecoration(color: colorBorder, borderRadius: BorderRadius.circular(5.r))),
                          ),
                          SizedBox(height: 5.h),
                          Text(color, style: bodyTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
                        ],
                      ),
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

  Widget _productSpecifications(ProductDetailsEntity data) {
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
          child: Text(data.design, style: _specValueStyle),
        ),
        Padding(padding: EdgeInsetsDirectional.only(start: 20.w, top: 10.h), child: Text(language.material, style: _specStyle)),
        Container(
          decoration: BoxDecoration(color: colorDivider, borderRadius: BorderRadius.circular(5.r)),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          margin: EdgeInsetsDirectional.only(start: 20.w, top: 5.h),
          child: Text(data.material, style: _specValueStyle),
        ),
        Padding(padding: EdgeInsetsDirectional.only(start: 20.w, top: 10.h), child: Text(language.origin, style: _specStyle)),
        Container(
          decoration: BoxDecoration(color: colorDivider, borderRadius: BorderRadius.circular(5.r)),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          margin: EdgeInsetsDirectional.only(start: 20.w, top: 5.h, bottom: 10.h),
          child: Text(data.country, style: _specValueStyle),
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

  Widget _deliveryOptions(ProductDetailsEntity data) {
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

  Widget _actionButtons(ProductDetailsEntity data) {
    return Consumer(
      builder: (context, ref, _) {
        var addedQuantity = ref.watch(cartProductQuantityProvider);
        if (addedQuantity == 0) {
          addedQuantity = data.quantity;
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(color: colorWhite, boxShadow: [BoxShadow(color: colorShadow, blurRadius: 5, spreadRadius: 0, offset: Offset(0, -5))]),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPress: () {
                    if (getIntDataFromUserBox(key: hiveUserId) == 0) {
                      ref.read(loginRequiredDialogProvider);
                      return;
                    }
                    if (addedQuantity == 0) {
                      addDataIntoCartBox(1);
                      ref.read(
                        addToCartProvider((
                          productId: data.id,
                          productVariantId: data.productVariantId,
                          size: data.uniqueSizes[ref.watch(productSizeProvider)],
                          color: data.uniqueColors[ref.watch(productColorProvider)],
                          isAddToCart: true,
                        )),
                      );
                    } else {
                      ref.read(navigationServiceProvider).navigateTo(CartScreen());
                    }
                  },
                  title: addedQuantity == 0 ? language.addToCart : language.goToCart,
                  backgroundColor: addedQuantity > 0 ? colorWhite : colorBlack,
                  textColor: colorPrimary,
                  borderedButton: addedQuantity > 0,
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: CustomButton(
                  title: language.buyNow,
                  onPress: () {
                    if (getIntDataFromUserBox(key: hiveUserId) == 0) {
                      ref.read(loginRequiredDialogProvider);
                      return;
                    }
                    if (addedQuantity == 0) {
                      addDataIntoCartBox(1);
                      ref.read(
                        addToCartProvider((
                          productId: data.id,
                          productVariantId: data.productVariantId,
                          size: data.uniqueSizes[ref.watch(productSizeProvider)],
                          color: data.uniqueColors[ref.watch(productColorProvider)],
                          isAddToCart: false,
                        )),
                      );
                    } else {
                      ref.read(navigationServiceProvider).navigateTo(CartScreen());
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _cartView(int totalQuantity) {
    return Consumer(
      builder: (context, ref, _) {
        return GestureDetector(
          onTap: () {
            ref.read(navigationServiceProvider).navigateTo(CartScreen());
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
                  child: Text(totalQuantity.toString(), style: bodyTextStyle(fontSize: 10.sp)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _favoriteButton() {
    return Padding(padding: EdgeInsetsDirectional.only(end: 10.w), child: Icon(Icons.favorite_outline, color: colorBlack));
  }
}
