import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/domain/favourites_box.dart';
import 'package:movies/domain/genre.dart';
import 'package:movies/domain/genres_box.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/domain/movies_box.dart';
import 'package:movies/repository/repository.dart';

class RepositoryManager {
  late Repository<Genre, GenresBox> genresRepository;
  late Repository<Movie, MoviesBox> moviesRepository;
  late Repository<Movie, FavouritesBox> favouritesRepository;
  RepositoryManager() {
    Hive.registerAdapter(GenreAdapter());
    Hive.registerAdapter(MovieAdapter());

    genresRepository = Repository<Genre, GenresBox>(GenresBox());
    moviesRepository = Repository<Movie, MoviesBox>(MoviesBox());
    favouritesRepository = Repository<Movie, FavouritesBox>(FavouritesBox());
  }
}
