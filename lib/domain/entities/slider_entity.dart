class SliderEntity {
  int? _id;
  int? _entityId;
  int? _type;
  String? _imageUrl;
  String? _name;
  bool? _isForMale;
  bool? _isForFemale;
  bool? _isForKids;

  SliderEntity({int? id, int? entityId, int? type, String? imageUrl, String? name, bool? isForMale, bool? isForFemale, bool? isForKids}) {
    _id = id;
    _entityId = entityId;
    _type = type;
    _imageUrl = imageUrl;
    _name = name;
  }

  int get id => _id ?? 0;

  int get entityId => _entityId ?? 0;

  int get type => _type ?? 0;

  String get imageUrl => _imageUrl ?? "";

  String get name => _name ?? "";

  bool get isForMale => _isForMale ?? false;

  bool get isForFemale => _isForFemale ?? false;

  bool get isForKids => _isForKids ?? false;
}
