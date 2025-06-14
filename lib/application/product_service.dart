import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../domain/entities/product_entity.dart';
import '../domain/repositories/product_repository.dart';

class ProductService extends StateNotifier<AsyncValue<List<ProductEntity>>?> {
  final ProductRepository productRepository;

  ProductService(this.productRepository) : super(null);

  Future<void> callNewArrivalProductsApi({int page = 1, bool isForMale = false, bool isForFemale = false, bool isForKids = false}) async {
    state = const AsyncLoading();
    try {
      final result = await productRepository.getNewProductList(page: page, isForMale: isForMale, isForFemale: isForFemale, isForKids: isForKids);
      if (result is ApiSuccess) {
        state = AsyncData(result.data);
      } else {
        state = AsyncError((result as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callNewArrivalProductsApi>>>", "error: ${e.toString()}");
      state = AsyncError(e, st);
    }
  }

  Future<void> callPopularProductsApi({int page = 1, bool isForMale = false, bool isForFemale = false, bool isForKids = false}) async {
    state = const AsyncLoading();
    try {
      final result = await productRepository.getPopularProductList(page: page, isForMale: isForMale, isForFemale: isForFemale, isForKids: isForKids);
      if (result is ApiSuccess) {
        state = AsyncData(result.data);
      } else {
        state = AsyncError((result as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callPopularProductsApi>>>", "error: ${e.toString()}");
      state = AsyncError(e, st);
    }
  }

  Future<void> callProductsApi({int page = 1, bool isForMale = false, bool isForFemale = false, bool isForKids = false}) async {
    state = const AsyncLoading();
    try {
      final result = await productRepository.getProductList(page: page, isForMale: isForMale, isForFemale: isForFemale, isForKids: isForKids);
      if (result is ApiSuccess) {
        state = AsyncData(result.data);
      } else {
        state = AsyncError((result as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      logD("callProductsApi>>>", "error: ${e.toString()}");
      state = AsyncError(e, st);
    }
  }

  Future<List<ProductEntity>> callAllProductsApi({int page = 1, bool isForMale = false, bool isForFemale = false, bool isForKids = false}) async {
    state = const AsyncLoading();
    try {
      final result = await productRepository.getProductList(page: page, isForMale: isForMale, isForFemale: isForFemale, isForKids: isForKids);
      if (result is ApiSuccess) {
        state = AsyncData(result.data);
        return result.data;
      } else {
        state = AsyncError((result as ApiError).errorData.message, StackTrace.empty);
        throw Exception("Failed to fetch products:");
      }
    } catch (e, st) {
      logD("callProductsApi>>>", "error: ${e.toString()}");
      state = AsyncError(e, st);
      throw Exception("Failed to fetch products: $e");
    }
  }

  Future<List<ProductEntity>> callFavoriteProductsApi({int page = 1, bool isForMale = false, bool isForFemale = false, bool isForKids = false}) async {
    state = const AsyncLoading();
    try {
      final result = await productRepository.getFavoriteProductList(page: page, isForMale: isForMale, isForFemale: isForFemale, isForKids: isForKids);
      if (result is ApiSuccess) {
        state = AsyncData(result.data);
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
}
