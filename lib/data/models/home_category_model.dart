import '../../domain/entities/home_category_entity.dart';

class HomeCategoryModel extends HomeCategoryEntity {
  HomeCategoryModel({super.id, super.action, super.type, super.name, super.image});

  factory HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    return HomeCategoryModel(id: json['id'], action: json['action'], type: json['type'], name: json['name'], image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'action': action, 'type': type, 'name': name, 'image': image};
  }
}
