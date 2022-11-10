import 'package:equatable/equatable.dart';

abstract class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object?> get props => [];
}

class GetPopularMovies extends PopularMoviesEvent {
  final bool isLoadMore;
  const GetPopularMovies({required this.isLoadMore});

  @override
  List<Object?> get props => [isLoadMore];
}
