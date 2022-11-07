import 'package:equatable/equatable.dart';
import 'package:movies/domain/movie.dart';

class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object?> get props => [];
}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesLoaded extends PopularMoviesState {
  final List<Movie>? movies;
  const PopularMoviesLoaded(this.movies);
}

class PopularMoviesError extends PopularMoviesState {}
