import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/repository/api_repository.dart';
import 'package:movies/repository/repository_manager.dart';
import 'package:movies/ui/pages/popular_movies_widget/bloc/popular_movies_bloc.dart';
import 'package:movies/ui/pages/popular_movies_widget/bloc/popular_movies_event.dart';
import 'package:movies/ui/pages/popular_movies_widget/bloc/popular_movies_state.dart';
import 'package:movies/ui/widgets/loading_indicator.dart';
import 'package:movies/ui/widgets/movie_list_item.dart';

class PopularMoviesWidget extends StatefulWidget {
  const PopularMoviesWidget({Key? key}) : super(key: key);

  @override
  State<PopularMoviesWidget> createState() => _PopularMoviesWidgetState();
}

class _PopularMoviesWidgetState extends State<PopularMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildPopularMoviesList();
  }

  Widget _buildPopularMoviesList() {
    return BlocProvider<PopularMoviesBloc>(
        create: (context) => PopularMoviesBloc(
            apiRepository:
                ApiRepository(repositoryManager: RepositoryManager()))
          ..add(
            GetPopularMovies(),
          ),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesInitial) {
              return _buildLoading();
            } else if (state is PopularMoviesLoading) {
              return _buildLoading();
            } else if (state is PopularMoviesLoaded) {
              return _buildCard(context, state.movies);
            }
            // else if (state is CovidError) {
            //   return Container();
            // }
            else {
              return Container();
            }
          },
        ));
  }

  Widget _buildCard(BuildContext context, List<Movie>? movies) {
    return ListView.builder(
      itemCount: movies?.length ?? 0,
      itemBuilder: (context, index) {
        return movies != null
            ? MovieListItem(movie: movies[index])
            : Container();
      },
    );
  }

  Widget _buildLoading() => LoadingIndicator();
}
