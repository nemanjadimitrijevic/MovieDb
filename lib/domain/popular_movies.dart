import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movies/domain/movie.dart';

part 'popular_movies.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class PopularMovies {
  @JsonKey(name: 'page')
  @HiveField(0)
  int? page;

  @JsonKey(name: 'results')
  @HiveField(1)
  List<Movie>? movies;

  @JsonKey(name: 'total_pages')
  @HiveField(2)
  int? totalPages;

  @JsonKey(name: 'total_results')
  @HiveField(3)
  int? totalResults;

  PopularMovies({this.page, this.movies, this.totalPages, this.totalResults});

  factory PopularMovies.fromJson(Map<String, dynamic> json) =>
      _$PopularMoviesFromJson(json);

  Map<String, dynamic> toJson() => _$PopularMoviesToJson(this);
}
