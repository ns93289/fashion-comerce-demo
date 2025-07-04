import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/product_service.dart';
import '../../application/slider_service.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/slider_repo_impl.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/slider_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/slider_repo.dart';

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

final sliderRepoProvider = Provider.autoDispose<SliderRepo>((ref) {
  return SliderRepoImpl();
});
final sliderServiceProvider = StateNotifierProvider.autoDispose<SliderService, AsyncValue<List<SliderEntity>>?>((ref) {
  return SliderService(ref.watch(sliderRepoProvider));
});
