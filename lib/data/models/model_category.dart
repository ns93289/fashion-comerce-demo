class ModelCategory {
  int? _categoryId;
  String? _categoryName;

  ModelCategory({int? categoryId, String? categoryName}) {
    _categoryId = categoryId;
    _categoryName = categoryName;
  }

  ModelCategory.fromJson(Map<String, dynamic> json) {
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category_id'] = _categoryId;
    data['category_name'] = _categoryName;
    return data;
  }

  int get categoryId => _categoryId ?? 0;

  String get categoryName => _categoryName ?? "";
}

class ModelSubCategory {
  int? _subCategoryId;
  int? _categoryId;
  int? _genderType;
  String? _subCategoryName;
  String? _subCategoryImage;
  String? _tagline;

  ModelSubCategory({int? subCategoryId, int? genderType, int? categoryId, String? subCategoryName, String? subCategoryImage, String? tagline}) {
    _subCategoryId = subCategoryId;
    _categoryId = categoryId;
    _subCategoryName = subCategoryName;
    _subCategoryImage = subCategoryImage;
    _genderType = genderType;
    _tagline = tagline;
  }

  ModelSubCategory.fromJson(Map<String, dynamic> json) {
    _subCategoryId = json['sub_category_id'];
    _categoryId = json['category_id'];
    _genderType = json['gender_type'];
    _subCategoryName = json['sub_category_name'];
    _subCategoryImage = json['sub_category_image'];
    _tagline = json['tagline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['sub_category_id'] = _subCategoryId;
    data['category_id'] = _categoryId;
    data['sub_category_name'] = _subCategoryName;
    data['sub_category_image'] = _subCategoryImage;
    data['gender_type'] = _genderType;
    data['tagline'] = _tagline;
    return data;
  }

  int get subCategoryId => _subCategoryId ?? 0;

  int get categoryId => _categoryId ?? 0;

  int get genderType => _genderType ?? 0;

  String get subCategoryName => _subCategoryName ?? "";

  String get subCategoryImage => _subCategoryImage ?? "";

  String get tagline => _tagline ?? "";
}
