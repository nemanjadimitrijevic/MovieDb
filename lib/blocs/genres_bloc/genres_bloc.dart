import 'package:bloc/bloc.dart';
import 'package:movies/blocs/genres_bloc/genres_event.dart';
import 'package:movies/blocs/genres_bloc/genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  GenresBloc(GenresState initialState) : super(initialState);
}
