import 'package:equatable/equatable.dart';
import 'package:movies/domain/popular_movies.dart';

class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object?> get props => [];
}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesLoaded extends PopularMoviesState {
  final PopularMovies movies;
  const PopularMoviesLoaded(this.movies);
}

class PopularMoviesError extends PopularMoviesState {}
