import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/domain/genres.dart';
import 'package:movies/domain/genres_box.dart';
import 'package:movies/domain/popular_movies.dart';

enum MoviesBoxType { genresBox, moviesBox, favouritesBox }

class RepositoryManager {
  Repository<Genres, GenresBox> genresRepository;
  RepositoryManager() {
    Hive.registerAdapter(GenresAdapter());
    Hive.registerAdapter(PopularMoviesAdapter());
  }
}
