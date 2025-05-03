class ModelProductFilter {
  int? _id;
  String? _categoryName;
  String? _categoryIcon;

  ModelProductFilter({int? id, String? categoryName, String? categoryIcon}) {
    _id = id;
    _categoryName = categoryName;
    _categoryIcon = categoryIcon;
  }

  int get id => _id ?? 0;

  String get categoryName => _categoryName ?? "";

  String get categoryIcon => _categoryIcon ?? "";
}

class ModelProduct {
  int? _id;
  String? _name;
  String? _image;
  String? _category;
  num? _price;
  bool? _favorite;

  ModelProduct({int? id, String? name, String? image, String? category, num? price, bool? favorite}) {
    _id = id;
    _name = name;
    _image = image;
    _category = category;
    _price = price;
    _favorite = favorite;
  }

  bool get favorite => _favorite ?? false;

  num get price => _price ?? 0;

  String get category => _category ?? "";

  String get image => _image ?? "";

  String get name => _name ?? "";

  int get id => _id ?? 0;
}
