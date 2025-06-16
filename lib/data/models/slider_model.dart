import '../../domain/entities/slider_entity.dart';

class SliderModel extends SliderEntity {
  SliderModel({super.id, super.entityId, super.type, super.imageUrl, super.name, super.isForMale, super.isForFemale, super.isForKids});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      entityId: json['action'],
      type: json['type'],
      imageUrl: json['image_url'],
      name: json['name'],
      isForMale: json['is_for_male'],
      isForFemale: json['is_for_female'],
      isForKids: json['is_for_kids'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['action'] = entityId;
    data['type'] = type;
    data['image_url'] = imageUrl;
    data['name'] = name;
    data['is_for_male'] = isForMale;
    data['is_for_female'] = isForFemale;
    data['is_for_kids'] = isForKids;
    return data;
  }
}
