import 'package:movies/domain/genre.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/repository/favourites_box.dart';
import 'package:movies/repository/genres_box.dart';
import 'package:movies/repository/movies_box.dart';
import 'package:movies/repository/repository.dart';

class RepositoryManager {
  late Repository<Genre, GenresBox> genresRepository;
  late Repository<Movie, MoviesBox> moviesRepository;
  late Repository<Movie, FavouritesBox> favouritesRepository;
  RepositoryManager() {
    genresRepository = Repository<Genre, GenresBox>(GenresBox());
    moviesRepository = Repository<Movie, MoviesBox>(MoviesBox());
    favouritesRepository = Repository<Movie, FavouritesBox>(FavouritesBox());
  }
}
