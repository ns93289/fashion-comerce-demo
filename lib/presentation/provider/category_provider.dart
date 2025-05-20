import 'package:fashion_comerce_demo/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../data/models/model_category.dart';

final categoryCategoryProvider = Provider.autoDispose<List<ModelCategory>>((ref) {
  return [
    ModelCategory(categoryId: 1, categoryName: language.topWear),
    ModelCategory(categoryId: 2, categoryName: language.bottomWear),
    ModelCategory(categoryId: 3, categoryName: language.footWear),
    ModelCategory(categoryId: 4, categoryName: language.accessories),
    ModelCategory(categoryId: 5, categoryName: language.collections),
  ];
});

final selectedCategoryProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final subCategoryCategoryProvider = Provider.autoDispose<List<ModelSubCategory>>((ref) {
  return [
    ModelSubCategory(subCategoryId: 1, categoryId: 1, subCategoryName: "Shirts"),
    ModelSubCategory(subCategoryId: 2, categoryId: 1, subCategoryName: "T-shirts"),
    ModelSubCategory(subCategoryId: 3, categoryId: 1, subCategoryName: "Jackets"),
    ModelSubCategory(subCategoryId: 4, categoryId: 1, subCategoryName: "Sweaters"),
    ModelSubCategory(subCategoryId: 5, categoryId: 2, subCategoryName: "Jeans"),
    ModelSubCategory(subCategoryId: 6, categoryId: 2, subCategoryName: "Pants"),
    ModelSubCategory(subCategoryId: 7, categoryId: 2, subCategoryName: "Shorts"),
    ModelSubCategory(subCategoryId: 8, categoryId: 2, subCategoryName: "Skirts", genderType: GenderTypes.female),
    ModelSubCategory(subCategoryId: 9, categoryId: 2, subCategoryName: "Dresses", genderType: GenderTypes.female),
    ModelSubCategory(subCategoryId: 10, categoryId: 3, subCategoryName: "Boots"),
    ModelSubCategory(subCategoryId: 11, categoryId: 3, subCategoryName: "Shoes"),
    ModelSubCategory(subCategoryId: 12, categoryId: 3, subCategoryName: "Slippers"),
    ModelSubCategory(subCategoryId: 13, categoryId: 3, subCategoryName: "Sandals"),
    ModelSubCategory(subCategoryId: 14, categoryId: 3, subCategoryName: "Flats"),
    ModelSubCategory(subCategoryId: 15, categoryId: 4, subCategoryName: "Watches"),
    ModelSubCategory(subCategoryId: 16, categoryId: 4, subCategoryName: "Bags"),
    ModelSubCategory(subCategoryId: 17, categoryId: 4, subCategoryName: "Hats"),
    ModelSubCategory(subCategoryId: 18, categoryId: 4, subCategoryName: "Sunglasses"),
    ModelSubCategory(subCategoryId: 19, categoryId: 4, subCategoryName: "Belts"),
    ModelSubCategory(subCategoryId: 20, categoryId: 5, subCategoryName: "Winter"),
    ModelSubCategory(subCategoryId: 21, categoryId: 5, subCategoryName: "Summer"),
    ModelSubCategory(subCategoryId: 22, categoryId: 5, subCategoryName: "Spring"),
    ModelSubCategory(subCategoryId: 23, categoryId: 5, subCategoryName: "Autumn"),
  ];
});

final genderWiseSubCategoryProvider = Provider.autoDispose.family<List<ModelSubCategory>, ({int categoryId, int genderType})>((ref, args) {
  List<ModelSubCategory> subCategories = ref.watch(subCategoryCategoryProvider);
  return subCategories
      .where((element) => element.categoryId == args.categoryId && (element.genderType == args.genderType || element.genderType == GenderTypes.all))
      .toList();
});
