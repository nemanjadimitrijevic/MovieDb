import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/repository/api_repository.dart';
import 'package:movies/ui/pages/home_page/bloc/genres_event.dart';
import 'package:movies/ui/pages/home_page/bloc/genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final ApiRepository apiRepository;
  GenresBloc({required this.apiRepository}) : super(GenresInitial()) {
    on<GetMovieGenres>(_getMovieGenres);
  }

  FutureOr<void> _getMovieGenres(
      GenresEvent event, Emitter<GenresState> emit) async {
    try {
      final genreList = await apiRepository.getMovieGenres();
      emit(GenresLoaded(genreList));
    } on NetworkError {
      emit(GenresError());
    }
  }
}
