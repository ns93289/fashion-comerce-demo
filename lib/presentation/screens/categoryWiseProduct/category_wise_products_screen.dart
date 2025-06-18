import 'package:fashion_comerce_demo/presentation/components/empty_record_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/theme.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_button.dart';
import '../../provider/category_wise_provider.dart';
import '../../provider/navigation_provider.dart';
import '../productList/item_product.dart';
import '../home/pages/home/offer_slider.dart';
import '../productDetails/product_details_screen.dart';
import '../productList/product_list_screen.dart';

class CategoryWiseProductsScreen extends ConsumerStatefulWidget {
  final int categoryId;
  final int action;
  final int type;
  final String categoryName;
  final bool isForMale;
  final bool isForFemale;
  final bool isForKids;

  const CategoryWiseProductsScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.isForMale,
    required this.isForFemale,
    required this.isForKids,
    this.action = 0,
    this.type = 0,
  });

  @override
  ConsumerState<CategoryWiseProductsScreen> createState() => _CategoryWiseProductsScreenState();
}

class _CategoryWiseProductsScreenState extends ConsumerState<CategoryWiseProductsScreen> {
  final _titleStyle = bodyTextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold);

  @override
  void initState() {
    Future.microtask(() {
      ref
          .read(newProductServiceProvider.notifier)
          .callNewArrivalProductsApi(
            productParams: ProductParams(
              isForMale: widget.isForMale,
              isForFemale: widget.isForFemale,
              isForKids: widget.isForKids,
              categoryId: widget.categoryId,
            ),
          );
      ref
          .read(popularProductServiceProvider.notifier)
          .callPopularProductsApi(
            productParams: ProductParams(
              isForMale: widget.isForMale,
              isForFemale: widget.isForFemale,
              isForKids: widget.isForKids,
              categoryId: widget.categoryId,
            ),
          );
      ref
          .read(allProductServiceProvider.notifier)
          .callProductsApi(
            productParams: ProductParams(
              isForMale: widget.isForMale,
              isForFemale: widget.isForFemale,
              isForKids: widget.isForKids,
              categoryId: widget.categoryId,
            ),
          );
      ref.read(sliderServiceProvider.notifier).callSliderApi(action: widget.action, type: widget.type);
    });
    super.initState();
  }

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
    return Consumer(
      builder: (context, ref, _) {
        final result = ref.watch(sliderServiceProvider);
        return result?.when(
              data: (sliderList) {
                return OfferSlider(sliderData: sliderList);
              },
              error: (error, stackTrace) => Container(),
              loading: () => Container(),
            ) ??
            Container();
      },
    );
  }

  Widget _newProducts() {
    return Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(newProductServiceProvider);
        return result?.when(
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
                            .navigateTo(
                              ProductListScreen(
                                productTypeName: language.newArrival,
                                productTypeEnum: ProductTypeEnum.newArrival,
                                isForMale: widget.isForMale,
                                isForFemale: widget.isForFemale,
                                isForKids: widget.isForKids,
                              ),
                            );
                      },
                    ),
                  ],
                );
              },
              error: (error, stackTrace) => Container(),
              loading: () => Container(),
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
                            .navigateTo(
                              ProductListScreen(
                                productTypeName: language.popular,
                                productTypeEnum: ProductTypeEnum.popular,
                                isForMale: widget.isForMale,
                                isForFemale: widget.isForFemale,
                                isForKids: widget.isForKids,
                              ),
                            );
                      },
                    ),
                  ],
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
                            .navigateTo(
                              ProductListScreen(
                                productTypeName: language.allProducts,
                                productTypeEnum: ProductTypeEnum.all,
                                isForMale: widget.isForMale,
                                isForFemale: widget.isForFemale,
                                isForKids: widget.isForKids,
                              ),
                            );
                      },
                    ),
                  ],
                );
              },
              error: (error, stackTrace) => Padding(padding: EdgeInsets.symmetric(vertical: 30.h), child: EmptyRecordView(message: error.toString())),
              loading: () => Container(),
            ) ??
            Container();
      },
    );
  }
}
