import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/common/colors.dart';
import 'package:movies/common/icons.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/repository/api_repository.dart';
import 'package:movies/repository/repository_manager.dart';
import 'package:movies/ui/pages/movie_details/bloc/movie_details_bloc.dart';
import 'package:movies/ui/pages/movie_details/bloc/movie_details_event.dart';
import 'package:movies/ui/pages/movie_details/bloc/movie_details_state.dart';
import 'package:movies/ui/widgets/loading_indicator.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;

  MovieDetails({Key? key, required this.movieId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(MovieColor.colorBg),
        body: SafeArea(
          child: _buildMovieDetailsBloc(),
        ));
  }

  Widget _buildMovieDetailsBloc() {
    return BlocProvider<MovieDetailsBloc>(
        create: (context) => MovieDetailsBloc(
            apiRepository:
                ApiRepository(repositoryManager: RepositoryManager()),
            movieId: widget.movieId)
          ..add(
            GetMovieDetails(),
          ),
        child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              _buildLoading();
            } else if (state is MovieDetailsLoaded) {
              return _buildMovieDetails(state.movie);
            }
            // TODO - error handling
            return Container();
          },
        ));
  }

  Widget _buildMovieDetails(Movie? movie) {
    if (movie == null) {
      return Container();
    }
    return Stack(
      children: [
        Column(
          children: [
            Image.network(
              movie.imageUrl(),
              width: double.infinity,
              height: 330,
              fit: BoxFit.cover,
            ),
          ],
        ),
        IconButton(
            icon: SvgPicture.asset(MovieSvgIcons.navBack),
            onPressed: () => {context.pop()}),
      ],
    );
  }

  Widget _buildLoading() => LoadingIndicator();
}
