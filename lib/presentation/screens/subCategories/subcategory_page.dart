import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/theme.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../main.dart';
import '../../components/custom_button.dart';
import '../../components/empty_record_view.dart';
import '../../provider/navigation_provider.dart';
import '../../provider/subcategory_products_provider.dart';
import '../productDetails/product_details_screen.dart';
import '../productList/item_product.dart';
import '../productList/product_list_screen.dart';

class SubcategoryPage extends ConsumerStatefulWidget {
  final int selectedSubCategoryId;
  final bool isForMale;
  final bool isForFemale;
  final bool isForKids;

  const SubcategoryPage({super.key, required this.selectedSubCategoryId, required this.isForMale, required this.isForFemale, required this.isForKids});

  @override
  ConsumerState<SubcategoryPage> createState() => _SubcategoryPageState();
}

class _SubcategoryPageState extends ConsumerState<SubcategoryPage> with AutomaticKeepAliveClientMixin {
  final _titleStyle = bodyTextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold);

  @override
  void initState() {
    Future.microtask(() {
      ref.read(newProductServiceProvider.notifier).callNewArrivalProductsApi(
        productParams: ProductParams(
          isForMale: widget.isForMale,
          isForFemale: widget.isForFemale,
          isForKids: widget.isForKids,
          categoryId: widget.selectedSubCategoryId,
        ),
      );
      ref.read(popularProductServiceProvider.notifier).callPopularProductsApi(
        productParams: ProductParams(
          isForMale: widget.isForMale,
          isForFemale: widget.isForFemale,
          isForKids: widget.isForKids,
          categoryId: widget.selectedSubCategoryId,
        ),
      );
      ref.read(allProductServiceProvider.notifier).callProductsApi(
        productParams: ProductParams(
          isForMale: widget.isForMale,
          isForFemale: widget.isForFemale,
          isForKids: widget.isForKids,
          categoryId: widget.selectedSubCategoryId,
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsetsDirectional.only(bottom: 20.h),
      child: Column(children: [_newProducts(), _popularProducts(), _allProducts()]),
    );
  }

  Widget _newProducts() {
    return Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(newProductServiceProvider);
        return result?.when(
              data: (productList) {
                return productList.isNotEmpty? Column(
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
                                productTypeEnum: ProductTypeEnum.newArrivalSubCategoryWise,
                                productTypeId: widget.selectedSubCategoryId,
                                isForMale: widget.isForMale,
                                isForFemale: widget.isForFemale,
                                isForKids: widget.isForKids,
                              ),
                            );
                      },
                    ),
                  ],
                ):SizedBox();
              },
              error: (error, stackTrace) => SizedBox(),
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
                return productList.isNotEmpty? Column(
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
                                productTypeEnum: ProductTypeEnum.popularSubCategoryWise,
                                productTypeId: widget.selectedSubCategoryId,
                                isForMale: widget.isForMale,
                                isForFemale: widget.isForFemale,
                                isForKids: widget.isForKids,
                              ),
                            );
                      },
                    ),
                  ],
                ):SizedBox();
              },
              error: (error, stackTrace) => SizedBox(),
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
                                productTypeEnum: ProductTypeEnum.allSubCategoryWise,
                                productTypeId: widget.selectedSubCategoryId,
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
              error: (error, stackTrace) => EmptyRecordView(message: error.toString()),
              loading: () => Container(),
            ) ??
            Container();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
