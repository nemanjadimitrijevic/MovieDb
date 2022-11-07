import 'package:equatable/equatable.dart';
import 'package:movies/domain/genres.dart';

class GenresState extends Equatable {
  const GenresState();

  @override
  List<Object?> get props => [];
}

class GenresInitial extends GenresState {}

class GenresLoading extends GenresState {}

class GenresLoaded extends GenresState {
  final Genres genres;
  const GenresLoaded(this.genres);
}

class GenresError extends GenresState {}
