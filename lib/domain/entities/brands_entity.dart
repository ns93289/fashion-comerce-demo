class BrandsEntity {
  int? _id;
  String? _name;
  String? _image;
  bool? _isForMale;
  bool? _isForFemale;
  bool? _isForKids;

  BrandsEntity({int? id, String? name, String? image, bool? isForMale, bool? isForFemale, bool? isForKids}) {
    _id = id;
    _name = name;
    _image = image;
  }

  int get id => _id ?? 0;

  String get name => _name ?? '';

  String get image => _image ?? '';

  bool get isForMale => _isForMale ?? false;

  bool get isForFemale => _isForFemale ?? false;

  bool get isForKids => _isForKids ?? false;
}
