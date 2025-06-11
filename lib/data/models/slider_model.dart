import '../../domain/entities/slider_entity.dart';

class SliderModel extends SliderEntity {
  SliderModel({super.id, super.entityId, super.type, super.imageUrl});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(id: json['id'], entityId: json['action'], type: json['type'], imageUrl: json['image_url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['action'] = entityId;
    data['type'] = type;
    data['image_url'] = imageUrl;
    return data;
  }
}
