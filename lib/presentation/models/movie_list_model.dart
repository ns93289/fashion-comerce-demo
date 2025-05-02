class MovieListModel {
  MovieListModel({int? page, List<MovieItem>? results, int? totalPages, int? totalResults}) {
    _page = page;
    _movieList = results;
    _totalPages = totalPages;
    _totalResults = totalResults;
  }

  MovieListModel.fromJson(dynamic json) {
    _page = json['page'];
    if (json['results'] != null) {
      _movieList = [];
      json['results'].forEach((v) {
        _movieList?.add(MovieItem.fromJson(v));
      });
    }
    _totalPages = json['total_pages'];
    _totalResults = json['total_results'];
  }

  int? _page;
  List<MovieItem>? _movieList;
  int? _totalPages;
  int? _totalResults;

  int get page => _page ?? 0;

  int get totalPages => _totalPages ?? 0;

  int get totalResults => _totalResults ?? 0;

  List<MovieItem> get movieList => _movieList ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    if (_movieList != null) {
      map['results'] = _movieList?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = _totalPages;
    map['total_results'] = _totalResults;
    return map;
  }
}

class MovieItem {
  MovieItem({
    String? backdropPath,
    int? id,
    String? title,
    String? originalTitle,
    String? overview,
    String? posterPath,
    String? mediaType,
    bool? adult,
    String? originalLanguage,
    List<int>? genreIds,
    double? popularity,
    String? releaseDate,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) {
    _backdropPath = backdropPath;
    _id = id;
    _title = title;
    _originalTitle = originalTitle;
    _overview = overview;
    _posterPath = posterPath;
    _mediaType = mediaType;
    _adult = adult;
    _originalLanguage = originalLanguage;
    _genreIds = genreIds;
    _popularity = popularity;
    _releaseDate = releaseDate;
    _video = video;
    _voteAverage = voteAverage;
    _voteCount = voteCount;
  }

  MovieItem.fromJson(dynamic json) {
    _backdropPath = json['backdrop_path'];
    _id = json['id'];
    _title = json['title'];
    _originalTitle = json['original_title'];
    _overview = json['overview'];
    _posterPath = json['poster_path'];
    _mediaType = json['media_type'];
    _adult = json['adult'];
    _originalLanguage = json['original_language'];
    _genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
    _popularity = json['popularity'];
    _releaseDate = json['release_date'];
    _video = json['video'];
    _voteAverage = json['vote_average'];
    _voteCount = json['vote_count'];
  }

  String? _backdropPath;
  int? _id;
  String? _title;
  String? _originalTitle;
  String? _overview;
  String? _posterPath;
  String? _mediaType;
  bool? _adult;
  String? _originalLanguage;
  List<int>? _genreIds;
  dynamic _popularity;
  String? _releaseDate;
  bool? _video;
  dynamic _voteAverage;
  int? _voteCount;

  int get id => _id ?? 0;

  int get voteCount => _voteCount ?? 0;

  String get backdropPath => "http://image.tmdb.org/t/p/w185/$_backdropPath";

  String get title => _title ?? "";

  String get originalTitle => _originalTitle ?? "";

  String get overview => _overview ?? "";

  String get posterPath => "http://image.tmdb.org/t/p/w185/$_posterPath";

  String get mediaType => _mediaType ?? "";

  String get originalLanguage => _originalLanguage ?? "";

  String get releaseDate => _releaseDate ?? "";

  dynamic get popularity => _popularity;

  dynamic get voteAverage => _voteAverage;

  bool get adult => _adult ?? false;

  bool get video => _video ?? false;

  List<int> get genreIds => _genreIds ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['backdrop_path'] = _backdropPath;
    map['id'] = _id;
    map['title'] = _title;
    map['original_title'] = _originalTitle;
    map['overview'] = _overview;
    map['poster_path'] = _posterPath;
    map['media_type'] = _mediaType;
    map['adult'] = _adult;
    map['original_language'] = _originalLanguage;
    map['genre_ids'] = _genreIds;
    map['popularity'] = _popularity;
    map['release_date'] = _releaseDate;
    map['video'] = _video;
    map['vote_average'] = _voteAverage;
    map['vote_count'] = _voteCount;
    return map;
  }
}
