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
    var movies = await _service.getPopularMovies();

    // Save movies into database
    movies.movies?.forEach((element) async {
      await repositoryManager.moviesRepository.put(element.id, element);
    });

    return await repositoryManager.moviesRepository.getAll();
  }

  Future<void> addFavouriteMovie(Movie movie) async {
    await repositoryManager.favouritesRepository.save(movie);
  }

  Future<List<Movie>?> getFavouriteMovies() async {
    return await repositoryManager.moviesRepository.getAll();
  }
}

class NetworkError extends Error {}
