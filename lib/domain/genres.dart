import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movies/domain/genre.dart';

part 'genres.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 0)
class Genres {
  @JsonKey(name: 'genres')
  @HiveField(0)
  List<Genre>? genres;

  Genres({this.genres});

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);

  Map<String, dynamic> toJson() => _$GenresToJson(this);
}
