import '../../domain/entities/category_entity.dart';

class ModelCategory extends CategoryEntity {
  ModelCategory({super.categoryId, super.categoryName, super.genderId});

  factory ModelCategory.fromJson(Map<String, dynamic> json) {
    return ModelCategory(categoryId: json['id'], categoryName: json['category_name'], genderId: json['gender_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = categoryId;
    data['category_name'] = categoryName;
    data['gender_id'] = genderId;
    return data;
  }
}

class ModelSubCategory extends SubCategoryEntity {
  ModelSubCategory({super.subCategoryId, super.categoryId, super.subCategoryName, super.subCategoryImage});

  factory ModelSubCategory.fromJson(Map<String, dynamic> json) {
    return ModelSubCategory(
      subCategoryId: json['id'],
      categoryId: json['category_id'],
      subCategoryName: json['sub_category_name'],
      subCategoryImage: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = subCategoryId;
    data['category_id'] = categoryId;
    data['sub_category_name'] = subCategoryName;
    data['image_url'] = subCategoryImage;
    return data;
  }
}
