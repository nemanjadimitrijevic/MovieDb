import 'package:equatable/equatable.dart';
import 'package:movies/domain/movie.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object?> get props => [];
}

class GetFavourites extends FavouritesEvent {}

class SaveFavoriteMovie extends FavouritesEvent {
  final Movie movie;
  const SaveFavoriteMovie({required this.movie});

  @override
  List<Object?> get props => [movie];
}

class DeleteFavoriteMovie extends FavouritesEvent {
  final int? movieId;
  const DeleteFavoriteMovie({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}
