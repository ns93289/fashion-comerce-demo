class CategoryEntity {
  int? _categoryId;
  String? _categoryName;
  bool? _isForMale;
  bool? _isForFemale;
  bool? _isForKids;

  CategoryEntity({int? categoryId, String? categoryName, bool? isForMale, bool? isForFemale, bool? isForKids}) {
    _categoryId = categoryId;
    _categoryName = categoryName;
    _isForMale = isForMale;
    _isForFemale = isForFemale;
    _isForKids = isForKids;
  }

  String get categoryName => _categoryName ?? "";

  int get categoryId => _categoryId ?? 0;

  bool get isForMale => _isForMale ?? false;

  bool get isForFemale => _isForFemale ?? false;

  bool get isForKids => _isForKids ?? false;
}

class SubCategoryEntity {
  int? _subCategoryId;
  int? _categoryId;
  String? _subCategoryName;
  String? _subCategoryImage;
  String? _tagLine;
  bool? _isForMale;
  bool? _isForFemale;
  bool? _isForKids;

  SubCategoryEntity({
    int? subCategoryId,
    int? categoryId,
    String? subCategoryName,
    String? subCategoryImage,
    String? tagLine,
    bool? isForMale,
    bool? isForFemale,
    bool? isForKids,
  }) {
    _subCategoryId = subCategoryId;
    _categoryId = categoryId;
    _subCategoryName = subCategoryName;
    _subCategoryImage = subCategoryImage;
    _tagLine = tagLine;
    _isForMale = isForMale;
    _isForFemale = isForFemale;
    _isForKids = isForKids;
  }

  int get subCategoryId => _subCategoryId ?? 0;

  int get categoryId => _categoryId ?? 0;

  String get subCategoryName => _subCategoryName ?? "";

  String get subCategoryImage => _subCategoryImage ?? "";

  String get tagLine => _tagLine ?? "";

  bool get isForMale => _isForMale ?? false;

  bool get isForFemale => _isForFemale ?? false;

  bool get isForKids => _isForKids ?? false;
}
