import 'package:json_annotation/json_annotation.dart';

part 'details.g.dart';

@JsonSerializable()
class MovieDetails {
  bool? adult;

  @JsonKey(name: 'backdrop_path')
  String? backdropPath;

  @JsonKey(name: 'belongs_to_collection')
  String? belongsToCollection;

  int? budget;

  List<Genre>? genres;

  String? homePage;

  int? id;

  @JsonKey(name: 'imdb_id')
  String? imdbId;

  @JsonKey(name: 'original_language')
  String? originalLanguage;

  @JsonKey(name: 'original_title')
  String? originalTitle;

  String? overview;

  double? popularity;

  @JsonKey(name: 'poster_path')
  String? posterPath;

  @JsonKey(name: 'release_date')
  String? releaseDate;

  String? status;

  String? tagline;

  String? title;

  bool? video;

  @JsonKey(name: 'vote_average')
  double? voteAverage;

  @JsonKey(name: 'vote_count')
  int? voteCount;

  MovieDetails(
      {this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homePage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.status,
      this.title,
      this.tagline,
      this.video,
      this.voteAverage,
      this.voteCount});

  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);

  MovieDetails.none()
      : adult = null,
        backdropPath = null,
        id = null,
        originalLanguage = null,
        originalTitle = null,
        overview = null,
        popularity = null,
        posterPath = null,
        releaseDate = null,
        video = null,
        title = null,
        voteAverage = null,
        voteCount = null;
}

@JsonSerializable()
class Genre {
  int? id;
  String? name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
