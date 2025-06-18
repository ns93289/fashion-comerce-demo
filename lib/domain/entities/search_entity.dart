class SearchResultEntity {
  List<SearchEntity>? _products;
  List<SearchEntity>? _brands;
  List<SearchEntity>? _subCategories;

  SearchResultEntity({List<SearchEntity>? products, List<SearchEntity>? brands, List<SearchEntity>? subCategories}) {
    _products = products;
    _brands = brands;
    _subCategories = subCategories;
  }

  List<SearchEntity> get products => _products ?? [];

  List<SearchEntity> get brands => _brands ?? [];

  List<SearchEntity> get subCategories => _subCategories ?? [];
}

class SearchEntity {
  int? _id;
  String? _name;
  bool? _isForMale;
  bool? _isForFemale;
  bool? _isForKids;

  SearchEntity({int? id, String? name, bool? isForMale, bool? isForFemale, bool? isForKids}) {
    _id = id;
    _name = name;
    _isForMale = isForMale;
    _isForFemale = isForFemale;
    _isForKids = isForKids;
  }

  int get id => _id ?? 0;

  String get name => _name ?? "";

  bool get isForMale => _isForMale ?? false;

  bool get isForFemale => _isForFemale ?? false;

  bool get isForKids => _isForKids ?? false;
}
