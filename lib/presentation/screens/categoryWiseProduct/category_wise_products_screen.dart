import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/theme.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_button.dart';
import '../../provider/home_provider.dart';
import '../../provider/navigation_provider.dart';
import '../productList/item_product.dart';
import '../home/pages/home/offer_slider.dart';
import '../productDetails/product_details_screen.dart';
import '../productList/product_list_screen.dart';

class CategoryWiseProductsScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryWiseProductsScreen({super.key, required this.categoryId, required this.categoryName});

  @override
  State<CategoryWiseProductsScreen> createState() => _CategoryWiseProductsScreenState();
}

class _CategoryWiseProductsScreenState extends State<CategoryWiseProductsScreen> {
  final _titleStyle = bodyTextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(widget.categoryName)), body: SafeArea(child: _buildCategoryWiseProducts()));
  }

  Widget _buildCategoryWiseProducts() {
    return SingleChildScrollView(
      padding: EdgeInsetsDirectional.only(bottom: 20.h),
      child: Column(children: [_offerSlider(), _newProducts(), _popularProducts(), _allProducts()]),
    );
  }

  Widget _offerSlider() {
    return OfferSlider(sliderData: []);
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
                          ref
                              .read(navigationServiceProvider)
                              .navigateTo(
                                ProductDetailsScreen(
                                  productId: product.productId,
                                  productName: product.productName,
                                  size: product.selectedSize,
                                  color: product.selectedColor,
                                ),
                              );
                        },
                        child: ItemProduct(
                          item: productList[index],
                          onFavorite: () {
                            ref.read(newProductServiceProvider.notifier).callToggleFavoriteApi(product.productId);
                          },
                        ),
                      );
                    },
                  ),
                ),
                CustomButton(
                  title: language.viewAll,
                  width: 1.sw,
                  margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 15.h),
                  onPress: () {
                    ref
                        .read(navigationServiceProvider)
                        .navigateTo(ProductListScreen(productType: language.newArrival, productTypeEnum: ProductTypeEnum.newArrival));
                  },
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
                          ref
                              .read(navigationServiceProvider)
                              .navigateTo(
                                ProductDetailsScreen(
                                  productId: product.productId,
                                  productName: product.productName,
                                  size: product.selectedSize,
                                  color: product.selectedColor,
                                ),
                              );
                        },
                        child: ItemProduct(
                          item: productList[index],
                          onFavorite: () {
                            ref.read(popularProductServiceProvider.notifier).callToggleFavoriteApi(product.productId);
                          },
                        ),
                      );
                    },
                  ),
                ),
                CustomButton(
                  title: language.viewAll,
                  width: 1.sw,
                  margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 15.h),
                  onPress: () {
                    ref.read(navigationServiceProvider).navigateTo(ProductListScreen(productType: language.popular, productTypeEnum: ProductTypeEnum.popular));
                  },
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
                          ref
                              .read(navigationServiceProvider)
                              .navigateTo(
                                ProductDetailsScreen(
                                  productId: product.productId,
                                  productName: product.productName,
                                  size: product.selectedSize,
                                  color: product.selectedColor,
                                ),
                              );
                        },
                        child: ItemProduct(
                          item: productList[index],
                          onFavorite: () {
                            ref.read(allProductServiceProvider.notifier).callToggleFavoriteApi(product.productId);
                          },
                        ),
                      );
                    },
                  ),
                ),
                CustomButton(
                  title: language.viewAll,
                  width: 1.sw,
                  margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 15.h),
                  onPress: () {
                    ref.read(navigationServiceProvider).navigateTo(ProductListScreen(productType: language.allProducts, productTypeEnum: ProductTypeEnum.all));
                  },
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
}
