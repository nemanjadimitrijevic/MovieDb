import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/domain/genre.dart';
import 'package:movies/domain/genres_box.dart';
import 'package:movies/domain/popular_movies.dart';
import 'package:movies/repository/repository.dart';

enum MoviesBoxType { genresBox, moviesBox, favouritesBox }

class RepositoryManager {
  late Repository<Genre, GenresBox> genresRepository;
  RepositoryManager() {
    Hive.registerAdapter(GenreAdapter());
    Hive.registerAdapter(PopularMoviesAdapter());

    genresRepository = Repository<Genre, GenresBox>(GenresBox());
  }
}
