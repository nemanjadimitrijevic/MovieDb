import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/repository/api_repository.dart';
import 'package:movies/ui/pages/popular_movies_widget/bloc/popular_movies_event.dart';
import 'package:movies/ui/pages/popular_movies_widget/bloc/popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final ApiRepository apiRepository;
  int page = 1;
  bool isFetching = false;
  PopularMoviesBloc({required this.apiRepository})
      : super(PopularMoviesInitial()) {
    on<GetPopularMovies>(_getPopularMovies);
  }

  FutureOr<void> _getPopularMovies(
      GetPopularMovies event, Emitter<PopularMoviesState> emit) async {
    try {
      emit(
          !event.isLoadMore ? PopularMoviesLoading() : PopularMoviesLoadMore());
      final response = await apiRepository.getPopularMovies(page);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final movieList = response.body as List<Movie>?;
        emit(!event.isLoadMore
            ? PopularMoviesLoaded(movieList)
            : PopularMoviesLoadMoreFinished(movieList));
        page++;
      } else {
        emit(PopularMoviesError());
      }
    } on NetworkError {
      emit(PopularMoviesError());
    }
  }
}
