import '../../domain/entities/brands_entity.dart';

class BrandsModel extends BrandsEntity {
  BrandsModel({super.id, super.name, super.image, super.isForMale, super.isForFemale, super.isForKids});

  factory BrandsModel.fromJson(Map<String, dynamic> json) {
    return BrandsModel(
      id: json['id'],
      name: json['name'],
      image: json['logo_url'],
      isForMale: json['is_for_male'],
      isForFemale: json['is_for_female'],
      isForKids: json['is_for_kids'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'logo_url': image, 'is_for_male': isForMale, 'is_for_female': isForFemale, 'is_for_kids': isForKids};
  }
}
