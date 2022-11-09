import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/common/colors.dart';
import 'package:movies/common/icons.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/repository/api_repository.dart';
import 'package:movies/repository/repository_manager.dart';
import 'package:movies/ui/pages/home_page/bloc/genres_bloc.dart';
import 'package:movies/ui/pages/home_page/bloc/genres_state.dart';
import 'package:movies/ui/pages/movie_details/bloc/movie_details_bloc.dart';
import 'package:movies/ui/pages/movie_details/bloc/movie_details_event.dart';
import 'package:movies/ui/pages/movie_details/bloc/movie_details_state.dart';
import 'package:movies/ui/widgets/favourites_button.dart';
import 'package:movies/ui/widgets/loading_indicator.dart';
import 'package:movies/ui/widgets/movie_genre_item.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;

  const MovieDetails({Key? key, required this.movieId}) : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              movie.imageUrl(),
              width: double.infinity,
              height: 330,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Color(MovieColor.colorBg),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            movie.title ?? "-",
                            style: const TextStyle(
                              color: Color(MovieColor.colorText),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          FavouritesButton(movie: movie)
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          SvgPicture.asset(MovieSvgIcons.star),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              '${movie.voteAverage}/10 IMDb',
                              style: const TextStyle(
                                color: Color(MovieColor.colorText),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _setGenres(movie.genres?.map((e) => e.id).toList()),
                      const SizedBox(height: 40),
                      const Text(
                        'Description',
                        style: TextStyle(
                          color: Color(MovieColor.colorText),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.overview ?? "",
                        style: const TextStyle(
                          color: Color(MovieColor.colorText),
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: IconButton(
              icon: SvgPicture.asset(MovieSvgIcons.navBack),
              onPressed: () => {context.pop()}),
        ),
      ],
    );
  }

  Widget _setGenres(List<int?>? genreIds) {
    if (genreIds == null || genreIds.isEmpty) {
      return Container();
    }
    return BlocBuilder<GenresBloc, GenresState>(
      builder: (context, state) {
        if (state is GenresLoaded) {
          return state.genres != null
              ? MovieGenreItems(genreIds: genreIds, genreList: state.genres)
              : Container();
        }
        return Container();
      },
    );
  }

  Widget _buildLoading() => LoadingIndicator();
}
