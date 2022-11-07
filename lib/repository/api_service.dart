import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movies/domain/genres.dart';
import 'package:movies/domain/popular_movies.dart';

class ApiService {
  static final Dio _dio = Dio();
  static const String _baseUrl = "https://api.themoviedb.org/3/";
  static const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
  static const String _genresUrl = '${_baseUrl}genre/movie/list';
  static const String _popularMoviesUrl =
      '${_baseUrl}movie/popular?api_key=b8d7f76947904a011286dc732c55234e&language=en_US&page=1';
  static const String _movieDetailsUrl =
      '${_baseUrl}movie/508947?api_key=b8d7f76947904a011286dc732c55234e&language=en_US&page=1';

  static const _lang = 'en_US';
  static const _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOGQ3Zjc2OTQ3OTA0YTAxMTI4NmRjNzMyYzU1MjM0ZSIsInN1YiI6IjYwMzM3ODBiMTEzODZjMDAzZjk0ZmM2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XYuIrLxvowrkevwKx-KhOiOGZ2Tn-R8tEksXq842kX4';

  Future<Genres> getMovieGenres() async {
    Response response = await _dio.get(_genresUrl);
    return Genres.fromJson(response.data);
  }

  Future<PopularMovies> getPopularMovies({int page = 1}) async {
    Response resp = await _dio.request(_popularMoviesUrl,
        queryParameters: {'language': _lang, 'page': page.toString()},
        options: Options(validateStatus: (_) => true, method: 'GET', headers: {
          HttpHeaders.authorizationHeader: 'Bearer $_token',
          'content-type': 'application/json'
        }));
    return PopularMovies.fromJson(resp.data);
  }
}
