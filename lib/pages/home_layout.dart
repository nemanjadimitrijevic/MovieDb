import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/blocs/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movies/blocs/popular_movies_bloc/popular_movies_state.dart';
import 'package:movies/common/colors.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/widgets/movie_list_item.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return _buildPopularMoviesList();
  }

  Widget _buildPopularMoviesList() {
    return Container(
        margin: const EdgeInsets.all(8.0),
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

  Widget _buildLoading() => const Center(
      child: CircularProgressIndicator(color: Color(MovieColor.colorPrimary)));
}
