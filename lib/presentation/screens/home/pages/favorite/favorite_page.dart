import 'package:fashion_comerce_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../domain/entities/product_entity.dart';
import '../../../../components/empty_record_view.dart';
import '../../../../provider/favorite_provider.dart';
import 'item_favorite_product.dart';

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
                ? ListView.builder(
                  itemCount: productList.length,
                  shrinkWrap: true,
                  padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
                  itemBuilder: (context, index) {
                    return ItemFavoriteProduct(
                      item: productList[index],
                      onUnfavorite: () {
                        ref.read(favoriteUnFavorite(productList[index]));
                      },
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
