class MovieDetailsModel {
  MovieDetailsModel({String? backdropPath, int? id, String? posterPath, String? releaseDate, String? title}) {
    _backdropPath = backdropPath;
    _id = id;
    _posterPath = posterPath;
    _releaseDate = releaseDate;
    _title = title;
  }

  MovieDetailsModel.fromJson(dynamic json) {
    _backdropPath = json['backdrop_path'];
    _id = json['id'];
    _posterPath = json['poster_path'];
    _releaseDate = json['release_date'];
    _title = json['title'];
    _overview = json['overview'];
  }

  String? _backdropPath;

  int? _id;

  String? _posterPath;

  String? _releaseDate;

  String? _title;
  String? _overview;

  int get id => _id ?? 0;

  String get backdropPath => "https://image.tmdb.org/t/p/w500/$_backdropPath";

  String get posterPath => "http://image.tmdb.org/t/p/w185/$_posterPath";

  String get releaseDate => _releaseDate ?? "";

  String get title => _title ?? "";

  String get overview => _overview ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['backdrop_path'] = _backdropPath;
    map['id'] = _id;
    map['poster_path'] = _posterPath;
    map['release_date'] = _releaseDate;
    map['title'] = _title;
    map['overview'] = _overview;
    return map;
  }
}
