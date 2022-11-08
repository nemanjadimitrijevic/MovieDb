import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/repository/api_repository.dart';
import 'package:movies/ui/pages/popular_movies_widget/bloc/popular_movies_event.dart';
import 'package:movies/ui/pages/popular_movies_widget/bloc/popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final ApiRepository apiRepository;
  PopularMoviesBloc({required this.apiRepository})
      : super(PopularMoviesInitial()) {
    on<GetPopularMovies>(_getPopularMovies);
  }

  FutureOr<void> _getPopularMovies(
      PopularMoviesEvent event, Emitter<PopularMoviesState> emit) async {
    try {
      emit(PopularMoviesLoading());
      final movieList = await apiRepository.getPopularMovies();
      emit(PopularMoviesLoaded(movieList));
    } on NetworkError {
      emit(PopularMoviesError());
    }
  }
}
