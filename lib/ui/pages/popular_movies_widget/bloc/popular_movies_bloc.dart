import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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
      final movieList = await apiRepository.getPopularMovies(page);
      emit(!event.isLoadMore
          ? PopularMoviesLoaded(movieList)
          : PopularMoviesLoadMoreFinished(movieList));
      page++;
    } on NetworkError {
      emit(PopularMoviesError());
    }
  }
}
