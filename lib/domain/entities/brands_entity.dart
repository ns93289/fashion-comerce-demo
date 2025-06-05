class BrandsEntity {
  int? _id;
  String? _name;
  String? _image;

  BrandsEntity({int? id, String? name, String? image}) {
    _id = id;
    _name = name;
    _image = image;
  }

  int get id => _id ?? 0;

  String get name => _name ?? '';

  String get image => _image ?? '';
}
