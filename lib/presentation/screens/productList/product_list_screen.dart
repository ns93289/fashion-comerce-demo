import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../domain/entities/product_entity.dart';
import '../../components/common_app_bar.dart';
import '../../components/common_circle_progress_bar.dart';
import '../../components/empty_record_view.dart';
import '../../provider/navigation_provider.dart';
import '../../provider/product_list_provider.dart';
import 'item_product.dart';
import '../productDetails/product_details_screen.dart';

class ProductListScreen extends StatefulWidget {
  final String productTypeName;
  final int productTypeId;
  final ProductTypeEnum productTypeEnum;
  final bool isForMale;
  final bool isForFemale;
  final bool isForKids;

  const ProductListScreen({
    super.key,
    required this.productTypeName,
    required this.productTypeEnum,
    this.productTypeId = 0,
    this.isForMale = false,
    this.isForFemale = false,
    this.isForKids = false,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(widget.productTypeName)), body: SafeArea(child: _buildProductList()));
  }

  Widget _buildProductList() {
    return Consumer(
      builder: (context, ref, child) {
        final pagingController = ref.watch(
          productListPagingStateProvider(
            ProductParams(
              isForMale: widget.isForMale,
              isForFemale: widget.isForFemale,
              isForKids: widget.isForKids,
              categoryId: widget.productTypeId,
              brandId: widget.productTypeId,
              productTypeEnum: widget.productTypeEnum,
            ),
          ),
        );

        return PagingListener<int, ProductEntity>(
          controller: pagingController,
          builder: (context, state, fetchNextPage) {
            return PagedGridView(
              state: state,
              fetchNextPage: fetchNextPage,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 5.w, mainAxisExtent: 225.h, mainAxisSpacing: 20.h),
              padding: EdgeInsetsDirectional.only(top: 10.h, bottom: 20.h, start: 20.w, end: 5.w),
              builderDelegate: PagedChildBuilderDelegate<ProductEntity>(
                itemBuilder: (context, product, index) {
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
                      item: product,
                      onFavorite: () {
                        ref.read(allProductServiceProvider.notifier).callToggleFavoriteApi(product.productId);
                      },
                    ),
                  );
                },
                firstPageErrorIndicatorBuilder: (context) {
                  return EmptyRecordView(message: state.error.toString());
                },
                newPageProgressIndicatorBuilder: (context) => CommonCircleProgressBar(),
              ),
            );
          },
        );
      },
    );
  }
}
