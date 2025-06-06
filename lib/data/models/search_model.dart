import '../../domain/entities/search_entity.dart';

class SearchModel extends SearchEntity {
  SearchModel({super.id, super.searchString});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(id: json['id'], searchString: json['search_string']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'search_string': searchString};
  }
}
