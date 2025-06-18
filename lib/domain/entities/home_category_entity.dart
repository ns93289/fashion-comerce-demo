class HomeCategoryEntity {
  int? _id;
  int? _action;
  int? _type;
  String? _name;
  String? _image;
  bool? _isForMale;
  bool? _isForFemale;
  bool? _isForKids;

  HomeCategoryEntity({int? id, int? action, int? type, String? name, String? image, bool? isForMale, bool? isForFemale, bool? isForKids}) {
    _id = id;
    _action = action;
    _type = type;
    _name = name;
    _image = image;
    _isForMale = isForMale;
    _isForFemale = isForFemale;
    _isForKids = isForKids;
  }

  int get id => _id ?? 0;

  int get action => _action ?? 0;

  int get type => _type ?? 0;

  String get name => _name ?? '';

  String get image => _image ?? '';

  bool get isForMale => _isForMale ?? false;

  bool get isForFemale => _isForFemale ?? false;

  bool get isForKids => _isForKids ?? false;
}
