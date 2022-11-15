import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/repository/api_repository.dart';
import 'package:movies/ui/pages/favourites_widget/bloc/favourites_event.dart';
import 'package:movies/ui/pages/favourites_widget/bloc/favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final ApiRepository apiRepository;

  FavouritesBloc({required this.apiRepository}) : super(FavouritesInitial()) {
    on<GetFavourites>(_getFavourites);
    on<SaveFavoriteMovie>(_saveFavouriteMovie);
    on<DeleteFavoriteMovie>(_deleteFavouriteMovie);
  }

  FutureOr<void> _getFavourites(
      FavouritesEvent event, Emitter<FavouritesState> emit) async {
    try {
      emit(FavouritesLoading());
      final movies = await apiRepository.getFavouriteMovies();
      emit(FavouritesLoaded(movies));
    } on NetworkError {
      emit(FavouritesError());
    }
  }

  Future<void> _saveFavouriteMovie(
      FavouritesEvent event, Emitter<FavouritesState> emit) async {
    try {
      emit(FavouritesLoading());
      if (event is SaveFavoriteMovie) {
        await apiRepository.saveFavouriteMovie(event.movie);
        emit(FavouriteSaved());
      }
    } on NetworkError {
      emit(FavouritesError());
    }
  }

  Future<void> _deleteFavouriteMovie(
      FavouritesEvent event, Emitter<FavouritesState> emit) async {
    emit(FavouritesLoading());
    if (event is DeleteFavoriteMovie) {
      await apiRepository.deleteFavouriteMovie(event.movieId);
      final movies = await apiRepository.getFavouriteMovies();
      emit(FavouritesLoaded(movies));
    }
  }
}
