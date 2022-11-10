import 'package:equatable/equatable.dart';
import 'package:movies/domain/movie.dart';

class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object?> get props => [];
}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesLoadMore extends PopularMoviesState {}

class PopularMoviesLoadMoreFinished extends PopularMoviesState {
  final List<Movie>? movies;
  const PopularMoviesLoadMoreFinished(this.movies);

  @override
  List<Object?> get props => [movies];
}

class PopularMoviesLoaded extends PopularMoviesState {
  final List<Movie>? movies;
  const PopularMoviesLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class PopularMoviesError extends PopularMoviesState {}
