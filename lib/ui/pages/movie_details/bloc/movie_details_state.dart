import 'package:equatable/equatable.dart';
import 'package:movies/domain/movie.dart';

class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object?> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final Movie? movie;
  const MovieDetailsLoaded(this.movie);
}

class MovieDetailsError extends MovieDetailsState {}
