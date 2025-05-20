import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_comerce_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/tools.dart';
import '../../../../../data/models/model_product.dart';
import '../../../../provider/favorite_provider.dart';
import '../../../../provider/home_provider.dart';
import '../../../productDetails/product_details_screen.dart';
import 'item_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsetsDirectional.only(bottom: 20.h),
      child: Column(children: [_offerSlider(), _newProducts(), _popularProducts(), _productCategories(), _allProducts()]),
    );
  }

  Widget _offerSlider() {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20.h),
      child: CarouselSlider(
        items: [
          AspectRatio(
            aspectRatio: 2,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: colorPrimary),
              margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
              height: double.maxFinite,
              width: double.maxFinite,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset("assets/images/slide1.jpg"),
            ),
          ),
          AspectRatio(
            aspectRatio: 2,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: colorPrimary),
              margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
              height: double.maxFinite,
              width: double.maxFinite,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset("assets/images/slide2.jpg"),
            ),
          ),
          AspectRatio(
            aspectRatio: 2,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: colorPrimary),
              margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
              height: double.maxFinite,
              width: double.maxFinite,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset("assets/images/slide3.jpg"),
            ),
          ),
        ],
        options: CarouselOptions(aspectRatio: 2, viewportFraction: 1, autoPlay: false, autoPlayAnimationDuration: Duration(seconds: 3)),
      ),
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
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
                  child: Row(
                    children: [
                      Expanded(child: Text(language.newArrival, style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
                      Text(language.seeAll, style: bodyTextStyle(fontSize: 14.sp)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 10.h),
                  height: 205.h,
                  child: ListView.builder(
                    itemCount: productList.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          openScreen(context, ProductDetailsScreen(productId: productList[index].productId));
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
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
                  child: Row(
                    children: [
                      Expanded(child: Text(language.popular, style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
                      Text(language.seeAll, style: bodyTextStyle(fontSize: 14.sp)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 10.h),
                  height: 205.h,
                  child: ListView.builder(
                    itemCount: productList.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          openScreen(context, ProductDetailsScreen(productId: productList[index].productId));
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
              ],
            );
          },
          error: (error, stackTrace) => Container(),
          loading: () => Container(),
        );
      },
    );
  }

  Widget _productCategories() {
    return Consumer(
      builder: (context, ref, child) {
        final List<ModelProductFilter> filters = ref.watch(categoryListProvider);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(top: 20.h, bottom: 10.h, start: 20.w),
              child: Text(language.exploreCategory, style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
            ),
            GridView.builder(
              itemCount: filters.length,
              padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4, crossAxisSpacing: 10.w, mainAxisSpacing: 10.h),
              itemBuilder: (context, index) {
                ModelProductFilter item = filters[index];

                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(20.r)),
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        Container(
                          height: 24.sp,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset(item.categoryIcon),
                        ),
                        Padding(padding: EdgeInsetsDirectional.only(start: 10.w), child: Text(item.categoryName, style: bodyTextStyle(fontSize: 12.sp))),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
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
                  child: Row(
                    children: [
                      Expanded(child: Text(language.allProducts, style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
                      Text(language.seeAll, style: bodyTextStyle(fontSize: 14.sp)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 10.h),
                  height: 205.h,
                  child: ListView.builder(
                    itemCount: productList.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          openScreen(context, ProductDetailsScreen(productId: productList[index].productId));
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
