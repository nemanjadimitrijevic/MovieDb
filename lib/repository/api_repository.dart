import 'package:movies/domain/genre.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/domain/popular_movies.dart';
import 'package:movies/repository/api_response.dart';
import 'package:movies/repository/api_service.dart';
import 'package:movies/repository/repository_manager.dart';

class ApiRepository {
  final RepositoryManager repositoryManager;
  final _service = ApiService();

  ApiRepository({required this.repositoryManager});

  Future<List<Genre?>?> getMovieGenres() async {
    // Get genres from the web
    var genres = await _service.getMovieGenres();
    var genresRepository = repositoryManager.genresRepository;

    // Save genres into database
    genres.genres?.forEach((element) {
      genresRepository.put(element.id, element);
    });

    return repositoryManager.genresRepository.getAll();
  }

  Future<List<Movie>?> getPopularMovies(int page) async {
    // Get movies from the web
    final response = await _service.getPopularMovies(page: page);
    // Save movies into database if the response was successful
    if (response.status == Status.completed) {
      final PopularMovies? popularMovies = response.data;
      popularMovies?.movies?.forEach((movie) async {
        await repositoryManager.moviesRepository.save(movie);
      });
    }
    return await repositoryManager.moviesRepository.getAll();
  }

  Future<Movie?> getMovieDetails(int movieId) async {
    // Get movie details from web
    var response = await _service.getMovieDetails(movieId: movieId);
    if (response.status == Status.completed) {
      final Movie? movie = response.data;
      repositoryManager.moviesRepository.put(movie?.id, movie);
      return movie;
    }
    final List<Movie>? allMovies =
        await repositoryManager.moviesRepository.getAll();
    return allMovies?.firstWhere((element) => element.id == movieId);
  }

  Future<List<Movie>?> getFavouriteMovies() async {
    return await repositoryManager.favouritesRepository.getAll();
  }

  Future<void> saveFavouriteMovie(Movie movie) async {
    await repositoryManager.favouritesRepository.put(movie.id, movie);
  }

  Future<void> deleteFavouriteMovie(int? movieId) async {
    await repositoryManager.favouritesRepository.deleteKey(movieId);
  }
}

class NetworkError extends Error {}
