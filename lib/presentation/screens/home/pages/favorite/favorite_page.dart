import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../main.dart';
import '../../../../../core/utils/tools.dart';
import '../../../../../domain/entities/product_entity.dart';
import '../../../../components/empty_record_view.dart';
import '../../../../provider/favorite_provider.dart';
import '../../../productDetails/product_details_screen.dart';
import '../home/item_product.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer(
      builder: (context, ref, child) {
        final data = ref.watch(favoriteProductListProvider);

        return data.when(
          data: (data) {
            List<ProductEntity> productList = data;
            return productList.isNotEmpty
                ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.w,
                    mainAxisExtent: 225.h,
                    mainAxisSpacing: 20.h,
                  ),
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
                )
                : EmptyRecordView(message: language.emptyFavoriteMsg);
          },
          error: (error, stackTrace) => EmptyRecordView(message: error.toString()),
          loading: () => Container(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
