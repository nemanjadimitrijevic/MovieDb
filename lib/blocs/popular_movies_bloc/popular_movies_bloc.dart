import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movies/blocs/popular_movies_bloc/popular_movies_event.dart';
import 'package:movies/blocs/popular_movies_bloc/popular_movies_state.dart';
import 'package:movies/resources/api_repository.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final ApiRepository _apiRepository = ApiRepository();
  PopularMoviesBloc() : super(PopularMoviesInitial()) {
    on<GetPopularMovies>(_getPopularMovies);
  }

  FutureOr<void> _getPopularMovies(
      PopularMoviesEvent event, Emitter<PopularMoviesState> emit) async {
    try {
      emit(PopularMoviesLoading());
      final movieList = await _apiRepository.getPopularMovies();
      emit(PopularMoviesLoaded(movieList));
    } on NetworkError {
      emit(PopularMoviesError());
    }
  }
}
