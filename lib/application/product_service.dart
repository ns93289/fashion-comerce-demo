import 'package:fashion_comerce_demo/data/models/base_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../domain/entities/product_entity.dart';
import '../domain/repositories/product_repository.dart';
import '../main.dart';

class ProductService extends StateNotifier<AsyncValue<List<ProductEntity>>?> {
  final ProductRepository productRepository;

  ProductService(this.productRepository) : super(null);

  Future<List<ProductEntity>?> callNewArrivalProductsApi({int page = 1, required ProductParams productParams}) async {
    state = const AsyncLoading();
    try {
      final result = await productRepository.getNewProductList(
        page: page,
        isForMale: productParams.isForMale,
        isForFemale: productParams.isForFemale,
        isForKids: productParams.isForKids,
        brandId: productParams.brandId,
        categoryId: productParams.categoryId,
      );
      if (result is ApiSuccess) {
        if (result.data is List<ProductEntity> && result.data.isNotEmpty) {
          state = AsyncData(result.data);
        } else {
          state = AsyncValue.error(language.emptyProductsMsg, StackTrace.empty);
        }
        return result.data;
      } else if (result is ApiError) {
        state = AsyncValue.error(result.errorData.message, StackTrace.empty);
      } else {
        state = const AsyncValue.error("Api response is neither success or error", StackTrace.empty);
      }
    } catch (e, st) {
      logD("callNewArrivalProductsApi>>>", "error: ${e.toString()}");
      state = AsyncError(e, st);
    }
    return null;
  }

  Future<List<ProductEntity>?> callPopularProductsApi({int page = 1, required ProductParams productParams}) async {
    state = const AsyncLoading();
    try {
      final result = await productRepository.getPopularProductList(
        page: page,
        isForMale: productParams.isForMale,
        isForFemale: productParams.isForFemale,
        isForKids: productParams.isForKids,
        brandId: productParams.brandId,
        categoryId: productParams.categoryId,
      );
      if (result is ApiSuccess) {
        if (result.data is List<ProductEntity> && result.data.isNotEmpty) {
          state = AsyncData(result.data);
        } else {
          state = AsyncValue.error(language.emptyProductsMsg, StackTrace.empty);
        }
        return result.data;
      } else if (result is ApiError) {
        state = AsyncValue.error(result.errorData.message, StackTrace.empty);
        throw Exception(result.errorData.message);
      } else {
        state = const AsyncValue.error("Api response is neither success or error", StackTrace.empty);
        throw Exception("Api response is neither success or error");
      }
    } catch (e, st) {
      logD("callPopularProductsApi>>>", "error: ${e.toString()}");
      state = AsyncError(e, st);
      throw Exception(e.toString());
    }
  }

  Future<List<ProductEntity>?> callProductsApi({int page = 1, required ProductParams productParams}) async {
    state = const AsyncLoading();
    try {
      final result = await productRepository.getProductList(
        page: page,
        isForMale: productParams.isForMale,
        isForFemale: productParams.isForFemale,
        isForKids: productParams.isForKids,
        brandId: productParams.brandId,
        categoryId: productParams.categoryId,
      );
      if (result is ApiSuccess) {
        if (result.data is List<ProductEntity> && result.data.isNotEmpty) {
          state = AsyncData(result.data);
        } else {
          state = AsyncValue.error(language.emptyProductsMsg, StackTrace.empty);
        }
        return result.data;
      } else if (result is ApiError) {
        state = AsyncValue.error(result.errorData.message, StackTrace.empty);
        throw Exception(result.errorData.message);
      } else {
        state = const AsyncValue.error("Api response is neither success or error", StackTrace.empty);
        throw Exception("Api response is neither success or error");
      }
    } catch (e, st) {
      logD("callProductsApi>>>", "error: ${e.toString()}");
      state = AsyncError(e, st);
      throw Exception(e.toString());
    }
  }

  Future<List<ProductEntity>> callFavoriteProductsApi() async {
    state = const AsyncLoading();
    try {
      final result = await productRepository.getFavoriteProductList();
      if (result is ApiSuccess) {
        if (result.data is List<ProductEntity> && result.data.isNotEmpty) {
          state = AsyncData(result.data);
        } else {
          state = AsyncValue.error(language.emptyProductsMsg, StackTrace.empty);
        }
        return result.data;
      } else {
        state = AsyncError((result as ApiError).errorData.message, StackTrace.empty);
        throw Exception("Failed to fetch products:");
      }
    } catch (e, st) {
      logD("callFavoriteProductsApi>>>", "error: ${e.toString()}");
      state = AsyncError(e, st);
      throw Exception("Failed to fetch products: $e");
    }
  }

  Future<void> callToggleFavoriteApi(int productId) async {
    final oldState = state;
    try {
      state = state?.whenData((products) {
        return products.map((product) {
          if (product.productId == productId) {
            final newFavoriteStatus = !product.favorite;
            // Optionally: call API here
            productRepository.favoriteProduct(productId: productId, favorite: newFavoriteStatus ? 1 : 2);
            return product.copyWith(favorite: newFavoriteStatus);
          }
          return product;
        }).toList();
      });
    } catch (e) {
      state = oldState; // rollback if needed
    }
  }

  Future<bool> callRemoveFavoriteApi(int productId) async {
    try {
      final result = await productRepository.favoriteProduct(productId: productId, favorite: 2);
      if (result is ApiSuccess) {
        if (result.data is BaseModel) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      logD("callRemoveFavoriteApi>>>", "error: ${e.toString()}");
      return false;
    }
  }

  Future<void> callToggleFavoriteApiInPaging({required int productId, required PagingController<int, ProductEntity> controller}) async {
    final currentState = controller.value;

    if (currentState.items == null) return;

    final oldItems = currentState.items ?? [];
    final updatedItems =
        oldItems.map((product) {
          if (product.productId == productId) {
            return product.copyWith(favorite: !product.favorite);
          }
          return product;
        }).toList();
    controller.mapItems((e) {
      if (e.productId == productId) {
        return e.copyWith(favorite: !e.favorite);
      }
      return e;
    });

    try {
      final toggledItem = updatedItems.firstWhere((p) => p.productId == productId);
      await productRepository.favoriteProduct(productId: productId, favorite: toggledItem.favorite ? 1 : 2);
    } catch (e) {
      controller.value = currentState; // rollback
    }
  }
}
