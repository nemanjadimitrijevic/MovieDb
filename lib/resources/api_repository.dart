import 'package:movies/domain/genres.dart';
import 'package:movies/domain/popular_movies.dart';
import 'package:movies/resources/api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<Genres> getMovieGenres() {
    return _provider.getMovieGenres();
  }

  Future<PopularMovies> getPopularMovies() {
    return _provider.getPopularMovies();
  }
}

class NetworkError extends Error {}
