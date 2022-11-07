import 'package:movies/domain/genre.dart';
import 'package:movies/domain/popular_movies.dart';
import 'package:movies/repository/api_service.dart';
import 'package:movies/repository/repository_manager.dart';

class ApiRepository {
  final RepositoryManager repositoryManager;
  final _service = ApiService();

  ApiRepository({required this.repositoryManager});

  Future<List<Genre?>?> getMovieGenres() async {
    var gen = await repositoryManager.genresRepository.getAll();
    var genres = await _service.getMovieGenres();
    var genresRepository = repositoryManager.genresRepository;
    genresRepository.clear();
    genresRepository.saveAll(genres.genres);

    return repositoryManager.genresRepository.getAll();
  }

  Future<PopularMovies> getPopularMovies() {
    return _service.getPopularMovies();
  }
}

class NetworkError extends Error {}
