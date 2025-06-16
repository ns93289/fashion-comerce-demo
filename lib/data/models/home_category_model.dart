import '../../domain/entities/home_category_entity.dart';

class HomeCategoryModel extends HomeCategoryEntity {
  HomeCategoryModel({super.id, super.action, super.type, super.name, super.image, super.isForMale, super.isForFemale, super.isForKids});

  factory HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    return HomeCategoryModel(
      id: json['id'],
      action: json['action'],
      type: json['type'],
      name: json['name'],
      image: json['image'],
      isForMale: json['is_for_male'],
      isForFemale: json['is_for_female'],
      isForKids: json['is_for_kids'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'action': action,
      'type': type,
      'name': name,
      'image': image,
      'is_for_male': isForMale,
      'is_for_female': isForFemale,
      'is_for_kids': isForKids,
    };
  }
}
