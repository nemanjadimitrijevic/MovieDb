import 'package:movies/domain/genre.dart';
import 'package:movies/domain/movie.dart';
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

  Future<List<Movie>?> getPopularMovies() async {
    // Get movies from the web
    var movies = await _service.getPopularMovies();

    // Save movies into database
    movies.movies?.forEach((element) async {
      await repositoryManager.moviesRepository.put(element.id, element);
    });

    return await repositoryManager.moviesRepository.getAll();
  }

  Future<Movie> getMovieDetails(int movieId) async {
    // Get movie details from web
    var movie = await _service.getMovieDetails(movieId: movieId);

    return movie;
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
