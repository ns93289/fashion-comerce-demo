import '../../domain/entities/category_entity.dart';

class ModelCategory extends CategoryEntity {
  ModelCategory({super.categoryId, super.categoryName, super.isForMale, super.isForFemale, super.isForKids});

  factory ModelCategory.fromJson(Map<String, dynamic> json) {
    return ModelCategory(
      categoryId: json['id'],
      categoryName: json['category_name'],
      isForMale: json['is_for_male'],
      isForFemale: json['is_for_female'],
      isForKids: json['is_for_kids'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = categoryId;
    data['category_name'] = categoryName;
    data['is_for_male'] = isForMale;
    data['is_for_female'] = isForFemale;
    data['is_for_kids'] = isForKids;
    return data;
  }
}

class ModelSubCategory extends SubCategoryEntity {
  ModelSubCategory({
    super.subCategoryId,
    super.categoryId,
    super.subCategoryName,
    super.subCategoryImage,
    super.tagLine,
    super.isForMale,
    super.isForFemale,
    super.isForKids,
  });

  factory ModelSubCategory.fromJson(Map<String, dynamic> json) {
    return ModelSubCategory(
      subCategoryId: json['id'],
      categoryId: json['category_id'],
      subCategoryName: json['name'],
      subCategoryImage: json['image_url'],
      tagLine: json['tag_line'],
      isForMale: json['is_for_male'],
      isForFemale: json['is_for_female'],
      isForKids: json['is_for_kids'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = subCategoryId;
    data['category_id'] = categoryId;
    data['name'] = subCategoryName;
    data['image_url'] = subCategoryImage;
    data['tag_line'] = tagLine;
    data['is_for_male'] = isForMale;
    data['is_for_female'] = isForFemale;
    data['is_for_kids'] = isForKids;
    return data;
  }
}
