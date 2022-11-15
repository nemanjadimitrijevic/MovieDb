import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movies/domain/genres.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/domain/popular_movies.dart';
import 'package:movies/repository/api_response.dart';

class ApiService {
  static final Dio _dio = Dio();
  static const String _baseUrl = "https://api.themoviedb.org/3/";
  static const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
  static const String _genresUrl = '${_baseUrl}genre/movie/list';
  static const String _popularMoviesUrl =
      '${_baseUrl}movie/popular?api_key=b8d7f76947904a011286dc732c55234e&language=en_US&page=1';
  static const String _movieDetailsUrl = '${_baseUrl}movie/';

  static const _lang = 'en_US';
  static const _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOGQ3Zjc2OTQ3OTA0YTAxMTI4NmRjNzMyYzU1MjM0ZSIsInN1YiI6IjYwMzM3ODBiMTEzODZjMDAzZjk0ZmM2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XYuIrLxvowrkevwKx-KhOiOGZ2Tn-R8tEksXq842kX4';

  final _options = Options(
      validateStatus: (_) => true,
      method: 'GET',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $_token',
        'content-type': 'application/json'
      },
      receiveTimeout: 1 * 1000);

  Future<Genres> getMovieGenres() async {
    Response response = await _dio.request(_genresUrl,
        queryParameters: {'language': _lang}, options: _options);
    return Genres.fromJson(response.data);
  }

  Future<ApiResponse> getPopularMovies({int page = 1}) async {
    try {
      var response = await _dio.request(_popularMoviesUrl,
          queryParameters: {'language': _lang, 'page': page.toString()},
          options: _options);
      return ApiResponse.completed(PopularMovies.fromJson(response.data));
    } on Exception {
      return ApiResponse.error("No internet error");
    }
  }

  Future<ApiResponse> getMovieDetails({int movieId = 0}) async {
    try {
      Response response = await _dio.request('$_movieDetailsUrl$movieId',
          queryParameters: {'language': _lang}, options: _options);
      return ApiResponse.completed(Movie.fromJson(response.data));
    } on Exception {
      return ApiResponse.error("No internet connection");
    }
  }
}
