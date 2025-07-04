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
import '../../../../components/empty_record_view.dart';
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

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with AutomaticKeepAliveClientMixin {
  final _titleStyle = bodyTextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    Future.microtask(() => _onRefresh());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator.adaptive(
      onRefresh: () {
        return _onRefresh();
      },
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(bottom: 20.h),
        child: Column(children: [_offerSlider(), _categoriesView(), _newProducts(), _popularProducts(), _productBrands(), _allProducts()]),
      ),
    );
  }

  Widget _offerSlider() {
    return Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(sliderServiceProvider);

        return result?.when(
              data: (sliderData) {
                return OfferSlider(sliderData: sliderData);
              },
              error: (error, stackTrace) => Container(),
              loading: () => CommonCircleProgressBar(),
            ) ??
            Container();
      },
    );
  }

  Widget _categoriesView() {
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
                      ref
                          .read(navigationServiceProvider)
                          .navigateTo(
                            CategoryWiseProductsScreen(
                              categoryId: category.type == 1 ? 0 : category.id,
                              action: category.action,
                              type: category.type,
                              categoryName: category.name,
                              isForMale: category.isForMale,
                              isForFemale: category.isForFemale,
                              isForKids: category.isForKids,
                            ),
                          );
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
  }

  Widget _newProducts() {
    final result = ref.watch(newProductServiceProvider);
    return result?.when(
          data: (productList) {
            return productList.isNotEmpty
                ? Column(
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
                            .navigateTo(ProductListScreen(productTypeName: language.newArrival, productTypeEnum: ProductTypeEnum.newArrival));
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
  }

  Widget _popularProducts() {
    final result = ref.watch(popularProductServiceProvider);
    return result?.when(
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
                    ref
                        .read(navigationServiceProvider)
                        .navigateTo(ProductListScreen(productTypeName: language.popular, productTypeEnum: ProductTypeEnum.popular));
                  },
                ),
              ],
            );
          },
          error: (error, stackTrace) => Container(),
          loading: () => Container(),
        ) ??
        Container();
  }

  Widget _productBrands() {
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
                      ref
                          .read(navigationServiceProvider)
                          .navigateTo(
                            BrandedProductsScreen(
                              brandId: brand.id,
                              brandName: brand.name,
                              isForMale: brand.isForMale,
                              isForFemale: brand.isForFemale,
                              isForKids: brand.isForKids,
                            ),
                          );
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
  }

  Widget _allProducts() {
    final result = ref.watch(allProductServiceProvider);
    return result?.when(
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
                    ref
                        .read(navigationServiceProvider)
                        .navigateTo(ProductListScreen(productTypeName: language.allProducts, productTypeEnum: ProductTypeEnum.all));
                  },
                ),
              ],
            );
          },
          error: (error, stackTrace) => EmptyRecordView(message: error.toString()),
          loading: () => Container(),
        ) ??
        Container();
  }

  Future<void> _onRefresh() {
    ref.read(sliderServiceProvider.notifier).callSliderApi();
    ref.read(homeCategoryServiceProvider.notifier).callHomeCategories();
    ref.read(brandsServiceProvider.notifier).callBrandsApi();
    ref.read(newProductServiceProvider.notifier).callNewArrivalProductsApi(productParams: ProductParams());
    ref.read(popularProductServiceProvider.notifier).callPopularProductsApi(productParams: ProductParams());
    return ref.read(allProductServiceProvider.notifier).callProductsApi(productParams: ProductParams());
  }
}
