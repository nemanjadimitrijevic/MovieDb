import 'package:movies/domain/genre.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/domain/popular_movies.dart';
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

  Future<dynamic> getPopularMovies(int page) async {
    // Get movies from the web
    var response = await _service.getPopularMovies(page: page);
    if (response.statusCode == 200) {
      final movies = PopularMovies.fromJson(response.data);
      // Save movies into database
      movies.movies?.forEach((element) async {
        await repositoryManager.moviesRepository.save(element);
      });
    }
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
