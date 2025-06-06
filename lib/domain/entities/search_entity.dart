class SearchEntity {
  int? _id;
  String? _searchString;

  SearchEntity({int? id, String? searchString}) {
    _id = id;
    _searchString = searchString;
  }

  int get id => _id ?? 0;

  String get searchString => _searchString ?? '';
}
