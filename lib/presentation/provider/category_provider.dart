import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/category_service.dart';
import '../../data/repositories/categories_repo_impl.dart';
import '../../domain/repositories/categories_rep.dart';

final selectedCategoryProvider = StateProvider.autoDispose.family<int, int>((ref, genderId) {
  return 0;
});

final categoryRepoProvider = Provider.autoDispose<CategoriesRepo>((ref) {
  return CategoriesRepoImpl();
});

final categoryServiceProvider = StateNotifierProvider<CategoryService, AsyncValue<dynamic>>((ref) {
  return CategoryService(ref.watch(categoryRepoProvider));
});

final subCategoryServiceProvider = StateNotifierProvider.family<CategoryService, AsyncValue<dynamic>, int>((ref, categoryId) {
  final service = CategoryService(ref.watch(categoryRepoProvider));
  service.callSubCategoryApi(categoryId: categoryId);
  return service;
});
