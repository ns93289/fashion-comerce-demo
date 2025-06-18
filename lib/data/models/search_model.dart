import '../../domain/entities/search_entity.dart';

class SearchResultModel extends SearchResultEntity {
  SearchResultModel({super.products, super.brands, super.subCategories});

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      products: (json['products'] as List?)?.map((e) => SearchModel.fromJson(e)).toList(),
      brands: (json['brands'] as List?)?.map((e) => SearchModel.fromJson(e)).toList(),
      subCategories: (json['sub_categories'] as List?)?.map((e) => SearchModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((e) => (e as SearchModel).toJson()).toList(),
      'brands': brands.map((e) => (e as SearchModel).toJson()).toList(),
      'sub_categories': subCategories.map((e) => (e as SearchModel).toJson()).toList(),
    };
  }
}

class SearchModel extends SearchEntity {
  SearchModel({super.id, super.name, super.isForMale, super.isForFemale, super.isForKids});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(id: json['id'], name: json['name'], isForMale: json['is_for_male'], isForFemale: json['is_for_female'], isForKids: json['is_for_kids']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'is_for_male': isForMale, 'is_for_female': isForFemale, 'is_for_kids': isForKids};
  }
}
