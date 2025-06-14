import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../domain/entities/home_category_entity.dart';
import '../../../../components/common_circle_progress_bar.dart';
import '../../../../../domain/entities/brands_entity.dart';
import '../../../../../domain/entities/product_entity.dart';
import '../../../../../main.dart';
import '../../../../components/custom_button.dart';
import '../../../../../core/constants/theme.dart';
import '../../../../../core/utils/tools.dart';
import '../../../../provider/home_provider.dart';
import '../../../../provider/navigation_provider.dart';
import '../../../brandedProducts/branded_products_screen.dart';
import '../../../brands/item_brand.dart';
import '../../../categoryWiseProduct/category_wise_products_screen.dart';
import '../../../productDetails/product_details_screen.dart';
import '../../../productList/product_list_screen.dart';
import 'item_home_category.dart';
import '../../../productList/item_product.dart';
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
    return Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(sliderServiceProvider);

        return result?.when(
              data: (sliderData) {
                if (sliderData.isNotEmpty) {
                  logD("_offerSlider>>>", sliderData.length.toString());
                  return OfferSlider(sliderData: sliderData);
                } else {
                  return Container();
                }
              },
              error: (error, stackTrace) => Container(),
              loading: () => CommonCircleProgressBar(),
            ) ??
            Container();
      },
    );
  }

  Widget _categoriesView() {
    return Consumer(
      builder: (context, ref, _) {
        final result = ref.watch(homeCategoryServiceProvider);

        return result.when(
          data: (data) {
            List<HomeCategoryEntity> categories = data as List<HomeCategoryEntity>? ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsetsDirectional.only(start: 20.w, bottom: 15.h, top: 15.h), child: Text(language.categories, style: _titleStyle)),
                SizedBox(
                  height: 83.h,
                  child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsetsDirectional.only(start: 20.w, end: 5.w),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      HomeCategoryEntity category = categories[index];
                      return GestureDetector(
                        onTap: () {
                          ref.read(navigationServiceProvider).navigateTo(CategoryWiseProductsScreen(categoryId: category.id, categoryName: category.name));
                        },
                        child: ItemHomeCategory(item: category),
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

  Widget _newProducts() {
    return Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(newProductServiceProvider);
        return result?.when(
              data: (productList) {
                return productList.isNotEmpty
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 20.w, bottom: 15.h, top: 15.h),
                          child: Text(language.newArrival, style: _titleStyle),
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
                    )
                    : Container();
              },
              error: (error, stackTrace) => Container(),
              loading: () => CommonCircleProgressBar(),
            ) ??
            Container();
      },
    );
  }

  Widget _popularProducts() {
    return Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(popularProductServiceProvider);
        return result?.when(
              data: (productList) {
                return productList.isNotEmpty
                    ? Column(
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
                            ref
                                .read(navigationServiceProvider)
                                .navigateTo(ProductListScreen(productType: language.popular, productTypeEnum: ProductTypeEnum.popular));
                          },
                        ),
                      ],
                    )
                    : Container();
              },
              error: (error, stackTrace) => Container(),
              loading: () => Container(),
            ) ??
            Container();
      },
    );
  }

  Widget _productBrands() {
    return Consumer(
      builder: (context, ref, _) {
        final result = ref.watch(brandsServiceProvider);

        return result?.when(
              data: (brandsList) {
                return Container(
                  height: 40.sp,
                  margin: EdgeInsetsDirectional.only(top: 20.h),
                  child: ListView.builder(
                    padding: EdgeInsetsDirectional.only(start: 20.w, end: 5.w),
                    itemBuilder: (context, index) {
                      BrandsEntity brand = brandsList[index];
                      return GestureDetector(
                        onTap: () {
                          ref.read(navigationServiceProvider).navigateTo(BrandedProductsScreen(brandsEntity: brand));
                        },
                        child: ItemBrand(brand: brand),
                      );
                    },
                    itemCount: brandsList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  ),
                );
              },
              error: (error, stackTrace) => Container(),
              loading: () => Container(),
            ) ??
            Container();
      },
    );
  }

  Widget _allProducts() {
    return Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(allProductServiceProvider);
        return result?.when(
              data: (productList) {
                return productList.isNotEmpty
                    ? Column(
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
                            ref
                                .read(navigationServiceProvider)
                                .navigateTo(ProductListScreen(productType: language.allProducts, productTypeEnum: ProductTypeEnum.all));
                          },
                        ),
                      ],
                    )
                    : Container();
              },
              error: (error, stackTrace) => Container(),
              loading: () => Container(),
            ) ??
            Container();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
