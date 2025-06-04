import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../domain/entities/product_entity.dart';
import '../../../../../main.dart';
import '../../../../components/custom_button.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/theme.dart';
import '../../../../../core/utils/tools.dart';
import '../../../../../data/models/model_product.dart';
import '../../../../provider/favorite_provider.dart';
import '../../../../provider/home_provider.dart';
import '../../../productDetails/product_details_screen.dart';
import 'item_home_category.dart';
import 'item_product.dart';
import 'offer_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final _titleStyle = bodyTextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsetsDirectional.only(bottom: 20.h),
      child: Column(children: [_offerSlider(), _categoriesView(), _newProducts(), _popularProducts(), _productBrands(), _allProducts()]),
    );
  }

  Widget _offerSlider() {
    return OfferSlider();
  }

  Widget _categoriesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsetsDirectional.only(start: 20.w, bottom: 15.h, top: 15.h), child: Text(language.categories, style: _titleStyle)),
        SizedBox(
          height: 83.h,
          child: ListView.builder(
            itemCount: 8,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsetsDirectional.only(start: 20.w, end: 5.w),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ItemHomeCategory();
            },
          ),
        ),
      ],
    );
  }

  Widget _newProducts() {
    return Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(newProductProvider);
        return result.when(
          data: (productList) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsetsDirectional.only(start: 20.w, bottom: 15.h, top: 15.h), child: Text(language.newArrival, style: _titleStyle)),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 10.h),
                  height: 225.h,
                  child: ListView.builder(
                    itemCount: productList.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsetsDirectional.only(start: 20.w, end: 5.w),
                    itemBuilder: (context, index) {
                      ProductEntity product = productList[index];
                      return GestureDetector(
                        onTap: () {
                          openScreen(context, ProductDetailsScreen(productId: product.productId, productName: product.productName));
                        },
                        child: ItemProduct(
                          item: productList[index],
                          onFavorite: () {
                            ref.read(favoriteUnFavorite(productList[index]));
                          },
                        ),
                      );
                    },
                  ),
                ),
                CustomButton(title: language.viewAll, width: 1.sw, margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 15.h)),
              ],
            );
          },
          error: (error, stackTrace) => Container(),
          loading: () => Container(),
        );
      },
    );
  }

  Widget _popularProducts() {
    return Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(popularProductProvider);
        return result.when(
          data: (productList) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w), child: Text(language.popular, style: _titleStyle)),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 10.h),
                  height: 225.h,
                  child: ListView.builder(
                    itemCount: productList.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsetsDirectional.only(start: 20.w, end: 5.w),
                    itemBuilder: (context, index) {
                      ProductEntity product = productList[index];
                      return GestureDetector(
                        onTap: () {
                          openScreen(context, ProductDetailsScreen(productId: product.productId, productName: product.productName));
                        },
                        child: ItemProduct(
                          item: productList[index],
                          onFavorite: () {
                            ref.read(favoriteUnFavorite(productList[index]));
                          },
                        ),
                      );
                    },
                  ),
                ),
                CustomButton(title: language.viewAll, width: 1.sw, margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 15.h)),
              ],
            );
          },
          error: (error, stackTrace) => Container(),
          loading: () => Container(),
        );
      },
    );
  }

  Widget _productBrands() {
    return Container(
      height: 40.sp,
      margin: EdgeInsetsDirectional.only(top: 20.h),
      child: ListView.builder(
        padding: EdgeInsetsDirectional.only(start: 20.w, end: 5.w),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(color: colorBorder, borderRadius: BorderRadius.circular(10.r)),
            margin: EdgeInsetsDirectional.only(end: 15.w),
            child: Row(
              children: [
                Container(decoration: BoxDecoration(color: colorBlack, borderRadius: BorderRadius.circular(10.r)), height: 40.sp, width: 40.sp),
                Padding(padding: EdgeInsets.symmetric(horizontal: 5.w), child: Text("Nike", style: bodyTextStyle(fontSize: 14.sp))),
              ],
            ),
          );
        },
        itemCount: 8,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _allProducts() {
    return Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(allProductProvider);
        return result.when(
          data: (productList) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
                  child: Row(children: [Expanded(child: Text(language.allProducts, style: _titleStyle))]),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 10.h),
                  height: 225.h,
                  child: ListView.builder(
                    itemCount: productList.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsetsDirectional.only(start: 20.w, end: 5.w),
                    itemBuilder: (context, index) {
                      ProductEntity product = productList[index];
                      return GestureDetector(
                        onTap: () {
                          openScreen(context, ProductDetailsScreen(productId: product.productId, productName: product.productName));
                        },
                        child: ItemProduct(
                          item: productList[index],
                          onFavorite: () {
                            ref.read(favoriteUnFavorite(productList[index]));
                          },
                        ),
                      );
                    },
                  ),
                ),
                CustomButton(title: language.viewAll, width: 1.sw, margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 15.h)),
              ],
            );
          },
          error: (error, stackTrace) => Container(),
          loading: () => Container(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
