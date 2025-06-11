import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/tools.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../main.dart';
import '../../components/common_circle_progress_bar.dart';
import '../../components/custom_button.dart';
import '../../components/empty_record_view.dart';
import '../../provider/category_provider.dart';
import '../../components/common_app_bar.dart';
import '../../provider/favorite_provider.dart';
import '../../provider/home_provider.dart';
import '../home/pages/home/item_product.dart';
import '../productDetails/product_details_screen.dart';
import '../productList/product_list_screen.dart';

class SubCategoriesScreen extends StatefulWidget {
  final int genderType;
  final int categoryId;
  final int selectedSubCategoryId;
  final String selectedSubCategoryName;

  const SubCategoriesScreen({
    super.key,
    required this.genderType,
    required this.categoryId,
    required this.selectedSubCategoryId,
    required this.selectedSubCategoryName,
  });

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  final _titleStyle = bodyTextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(widget.selectedSubCategoryName)), body: SafeArea(child: _buildSubCategories()));
  }

  Widget _buildSubCategories() {
    return Consumer(
      builder: (context, ref, _) {
        final apiResponse = ref.watch(subCategoryServiceProvider(widget.categoryId));

        return apiResponse.when(
          data: (data) {
            if (data == null) {
              return CommonCircleProgressBar();
            }
            List<SubCategoryEntity> subCategories = data as List<SubCategoryEntity>;
            int selectedIndex = subCategories.indexWhere((element) => element.subCategoryId == widget.selectedSubCategoryId);

            return DefaultTabController(length: subCategories.length, initialIndex: selectedIndex, child: _genderWiseSubCategories(subCategories));
          },
          error: (error, stackTrace) {
            debugPrintStack(stackTrace: stackTrace);
            return EmptyRecordView(message: error.toString());
          },
          loading: () => CommonCircleProgressBar(),
        );
      },
    );
  }

  Widget _genderWiseSubCategories(List<SubCategoryEntity> subCategories) {
    return Consumer(
      builder: (context, ref, _) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(color: colorWhite, boxShadow: [BoxShadow(color: colorShadow, blurRadius: 5, spreadRadius: 0, offset: Offset(0, 0))]),
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: TabBar(
                tabs: subCategories.map((e) => Tab(text: e.subCategoryName, height: 25.h)).toList(),
                labelStyle: bodyTextStyle(fontWeight: FontWeight.w500),
                unselectedLabelColor: colorTextLight,
                labelColor: colorPrimary,
                indicatorColor: colorPrimary,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.transparent,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsetsDirectional.only(bottom: 20.h),
                child: Column(children: [_newProducts(), _popularProducts(), _allProducts()]),
              ),
            ),
          ],
        );
      },
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
                          openScreen(
                            context,
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
                            ref.read(favoriteUnFavorite(productList[index]));
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
                    openScreen(context, ProductListScreen(productType: language.newArrival, productTypeEnum: ProductTypeEnum.newArrival));
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
                          openScreen(
                            context,
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
                            ref.read(favoriteUnFavorite(productList[index]));
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
                    openScreen(context, ProductListScreen(productType: language.popular, productTypeEnum: ProductTypeEnum.popular));
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
                          openScreen(
                            context,
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
                            ref.read(favoriteUnFavorite(productList[index]));
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
                    openScreen(context, ProductListScreen(productType: language.allProducts, productTypeEnum: ProductTypeEnum.all));
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
