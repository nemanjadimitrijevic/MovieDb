import 'package:hive_flutter/adapters.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/repository/repository_box.dart';

class FavouritesBox extends RepositoryBox {
  @override
  var box = Hive.openBox<Movie>('favourites_box');
}
