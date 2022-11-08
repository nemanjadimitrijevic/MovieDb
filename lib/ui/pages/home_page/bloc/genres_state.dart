import 'package:equatable/equatable.dart';
import 'package:movies/domain/genre.dart';

class GenresState extends Equatable {
  const GenresState();

  @override
  List<Object?> get props => [];
}

class GenresInitial extends GenresState {}

class GenresLoaded extends GenresState {
  final List<Genre?>? genres;
  const GenresLoaded(this.genres);
}

class GenresError extends GenresState {}
