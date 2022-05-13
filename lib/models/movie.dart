import 'dart:convert';

import 'package:hive/hive.dart';
part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie {
  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  @HiveField(0)
  bool adult;
  @HiveField(1)
  String? backdropPath;
  @HiveField(2)
  List<int> genreIds;
  @HiveField(3)
  int id;
  @HiveField(4)
  String originalLanguage;
  @HiveField(5)
  String originalTitle;
  @HiveField(6)
  String overview;
  @HiveField(7)
  double popularity;
  @HiveField(8)
  String? posterPath;
  @HiveField(9)
  String? releaseDate;
  @HiveField(10)
  String title;
  @HiveField(11)
  bool video;
  @HiveField(12)
  double voteAverage;
  @HiveField(13)
  int voteCount;

  String? heroId;

  get fullPosterImg {
    if (posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  get fullBackdropPath {
    if (backdropPath != null) {
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
