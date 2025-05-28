class CategoryEntity {
  int? _categoryId;
  int? _genderId;
  String? _categoryName;

  CategoryEntity({int? categoryId, String? categoryName, int? genderId}) {
    _categoryId = categoryId;
    _genderId = genderId;
    _categoryName = categoryName;
  }

  String get categoryName => _categoryName ?? "";

  int get categoryId => _categoryId ?? 0;

  int get genderId => _genderId ?? 0;
}

class SubCategoryEntity {
  int? _subCategoryId;
  int? _categoryId;
  String? _subCategoryName;
  String? _subCategoryImage;
  String? _tagLine;

  SubCategoryEntity({int? subCategoryId, int? categoryId, String? subCategoryName, String? subCategoryImage, String? tagLine}) {
    _subCategoryId = subCategoryId;
    _categoryId = categoryId;
    _subCategoryName = subCategoryName;
    _subCategoryImage = subCategoryImage;
    _tagLine = tagLine;
  }

  int get subCategoryId => _subCategoryId ?? 0;

  int get categoryId => _categoryId ?? 0;

  String get subCategoryName => _subCategoryName ?? "";

  String get subCategoryImage => _subCategoryImage ?? "";

  String get tagLine => _tagLine ?? "";
}
