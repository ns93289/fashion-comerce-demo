import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/tools.dart';
import '../../../domain/entities/product_entity.dart';
import '../../components/common_app_bar.dart';
import '../../components/empty_record_view.dart';
import '../../provider/favorite_provider.dart';
import '../../provider/home_provider.dart';
import '../home/pages/home/item_product.dart';
import '../productDetails/product_details_screen.dart';

class ProductListScreen extends StatefulWidget {
  final String productType;
  final ProductTypeEnum productTypeEnum;

  const ProductListScreen({super.key, required this.productType, required this.productTypeEnum});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(widget.productType)), body: SafeArea(child: _buildProductList()));
  }

  Widget _buildProductList() {
    return Consumer(
      builder: (context, ref, child) {
        AsyncValue<List<ProductEntity>> result;
        if (widget.productTypeEnum == ProductTypeEnum.newArrival) {
          result = ref.watch(newProductProvider);
        } else if (widget.productTypeEnum == ProductTypeEnum.popular) {
          result = ref.watch(popularProductProvider);
        } else {
          result = ref.watch(allProductProvider);
        }

        return result.when(
          data: (productList) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 5.w, mainAxisExtent: 225.h, mainAxisSpacing: 20.h),
              padding: EdgeInsetsDirectional.only(bottom: 20.h, start: 20.w, end: 5.w),
              itemCount: productList.length,
              shrinkWrap: true,
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
            );
          },
          error: (error, stackTrace) => EmptyRecordView(message: error.toString()),
          loading: () => Container(),
        );
      },
    );
  }
}
