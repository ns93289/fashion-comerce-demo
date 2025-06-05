import '../../domain/entities/brands_entity.dart';

class BrandsModel extends BrandsEntity {
  BrandsModel({super.id, super.name, super.image});

  factory BrandsModel.fromJson(Map<String, dynamic> json) {
    return BrandsModel(id: json['id'], name: json['name'], image: json['logo_url']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'logo_url': image};
  }
}
