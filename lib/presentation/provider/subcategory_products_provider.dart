import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/product_service.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

final productRepoProvider = Provider.autoDispose<ProductRepository>((ref) {
  return ProductRepositoryImpl();
});

final newProductServiceProvider = StateNotifierProvider.autoDispose<ProductService, AsyncValue<List<ProductEntity>>?>((ref) {
  return ProductService(ref.watch(productRepoProvider));
});
final popularProductServiceProvider = StateNotifierProvider.autoDispose<ProductService, AsyncValue<List<ProductEntity>>?>((ref) {
  return ProductService(ref.watch(productRepoProvider));
});
final allProductServiceProvider = StateNotifierProvider.autoDispose<ProductService, AsyncValue<List<ProductEntity>>?>((ref) {
  return ProductService(ref.watch(productRepoProvider));
});
