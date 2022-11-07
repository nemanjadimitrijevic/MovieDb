import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/repository/api_repository.dart';
import 'package:movies/ui/pages/movie_details/bloc/movie_details_event.dart';
import 'package:movies/ui/pages/movie_details/bloc/movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final ApiRepository apiRepository;
  final int movieId;

  MovieDetailsBloc({required this.movieId, required this.apiRepository})
      : super(MovieDetailsInitial()) {
    on<GetMovieDetails>(_getMovieDetails);
  }

  FutureOr<void> _getMovieDetails(
      MovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    try {
      emit(MovieDetailsLoading());
      final movie = await apiRepository.getMovieDetails(movieId);
      emit(MovieDetailsLoaded(movie));
    } on NetworkError {
      emit(MovieDetailsError());
    }
  }
}
