import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../application/product_service.dart';
import '../../core/constants/app_constants.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

final productRepoProvider = Provider.autoDispose<ProductRepository>((ref) {
  return ProductRepositoryImpl();
});

final allProductServiceProvider = StateNotifierProvider<ProductService, AsyncValue<List<ProductEntity>>?>((ref) {
  return ProductService(ref.watch(productRepoProvider));
});

final productListPagingStateProvider = Provider.autoDispose.family<PagingController<int, ProductEntity>, ProductParams>((ref, productParams) {
  return PagingController<int, ProductEntity>(
    getNextPageKey: (state) {
      if (state.keys?.length == DefaultData.pageSize) {
        return (state.keys?.last ?? 0) + 1;
      } else if (state.keys?.length == null) {
        return 1;
      } else {
        return null;
      }
    },
    fetchPage: (pageKey) async {
      if (productParams.productTypeEnum == ProductTypeEnum.newArrival ||
          productParams.productTypeEnum == ProductTypeEnum.newArrivalBrandWise ||
          productParams.productTypeEnum == ProductTypeEnum.newArrival) {
        if (productParams.productTypeEnum == ProductTypeEnum.newArrivalBrandWise) {
          productParams.categoryId = 0;
        } else if (productParams.productTypeEnum == ProductTypeEnum.newArrivalSubCategoryWise) {
          productParams.brandId = 0;
        }
        return await ref.read(allProductServiceProvider.notifier).callNewArrivalProductsApi(page: pageKey, productParams: productParams) ?? [];
      } else if (productParams.productTypeEnum == ProductTypeEnum.popular ||
          productParams.productTypeEnum == ProductTypeEnum.popularBrandWise ||
          productParams.productTypeEnum == ProductTypeEnum.popularSubCategoryWise) {
        if (productParams.productTypeEnum == ProductTypeEnum.popularBrandWise) {
          productParams.categoryId = 0;
        } else if (productParams.productTypeEnum == ProductTypeEnum.popularSubCategoryWise) {
          productParams.brandId = 0;
        }
        return await ref.read(allProductServiceProvider.notifier).callPopularProductsApi(page: pageKey, productParams: productParams) ?? [];
      } else {
        if (productParams.productTypeEnum == ProductTypeEnum.allBrandWise) {
          productParams.categoryId = 0;
        } else if (productParams.productTypeEnum == ProductTypeEnum.allSubCategoryWise) {
          productParams.brandId = 0;
        }
        return await ref.read(allProductServiceProvider.notifier).callProductsApi(page: pageKey, productParams: productParams) ?? [];
      }
    },
  );
});
