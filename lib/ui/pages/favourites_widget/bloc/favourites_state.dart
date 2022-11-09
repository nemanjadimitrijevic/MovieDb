import 'package:equatable/equatable.dart';
import 'package:movies/domain/movie.dart';

class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object?> get props => [];
}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final List<Movie>? favourites;
  const FavouritesLoaded(this.favourites);

  @override
  List<Object?> get props => [favourites];
}

class FavouriteSaved extends FavouritesState {}

class FavouriteDeleted extends FavouritesState {}

class FavouritesError extends FavouritesState {}
