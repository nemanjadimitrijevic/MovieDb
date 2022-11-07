import 'package:movies/domain/genres.dart';
import 'package:movies/domain/popular_movies.dart';
import 'package:movies/repository/api_service.dart';

class ApiRepository {
  final _service = ApiService();

  Future<Genres> getMovieGenres() {
    return _service.getMovieGenres();
  }

  Future<PopularMovies> getPopularMovies() {
    return _service.getPopularMovies();
  }
}

class NetworkError extends Error {}
