class SliderEntity {
  int? _id;
  int? _entityId;
  int? _type;
  String? _imageUrl;

  SliderEntity({int? id, int? entityId, int? type, String? imageUrl}) {
    _id = id;
    _entityId = entityId;
    _type = type;
    _imageUrl = imageUrl;
  }

  int get id => _id ?? 0;

  int get entityId => _entityId ?? 0;

  int get type => _type ?? 0;

  String get imageUrl => _imageUrl ?? "";
}
