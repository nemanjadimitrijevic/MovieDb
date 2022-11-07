import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movies/blocs/genres_bloc/genres_event.dart';
import 'package:movies/blocs/genres_bloc/genres_state.dart';
import 'package:movies/repository/api_repository.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final ApiRepository apiRepository;
  GenresBloc({required this.apiRepository}) : super(GenresInitial()) {
    on<GetMovieGenres>(_getMovieGenres);
  }

  FutureOr<void> _getMovieGenres(
      GenresEvent event, Emitter<GenresState> emit) async {
    try {
      // emit(GenresLoading());
      final genreList = await apiRepository.getMovieGenres();
      emit(GenresLoaded(genreList));
    } on NetworkError {
      emit(GenresError());
    }
  }
}
