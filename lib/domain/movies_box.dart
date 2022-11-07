import 'package:hive_flutter/adapters.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/repository/repository_box.dart';

class MoviesBox extends RepositoryBox {
  @override
  var box = Hive.openBox<Movie>('movies_box');
}
