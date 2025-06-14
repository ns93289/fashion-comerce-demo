import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/dataSources/remote/api_reponse.dart';
import '../domain/repositories/categories_rep.dart';

class CategoryService extends StateNotifier<AsyncValue<dynamic>> {
  final CategoriesRepo categoriesRepo;

  CategoryService(this.categoriesRepo) : super(const AsyncValue.data(null));

  Future<void> callCategoryApi({required int genderId}) async {
    state = const AsyncValue.loading();
    try {
      final res = await categoriesRepo.getCategories(genderId: genderId);
      if (res is ApiSuccess) {
        state = AsyncValue.data(res.data);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> callSubCategoryApi({required int categoryId, bool isForMale = false, bool isForFemale = false, bool isForKids = false}) async {
    state = const AsyncValue.loading();
    try {
      final res = await categoriesRepo.getSubCategories(categoryId: categoryId, isForMale: isForMale, isForFemale: isForFemale, isForKids: isForKids);
      if (res is ApiSuccess) {
        state = AsyncValue.data(res.data);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
