import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/common/colors.dart';
import 'package:movies/common/icons.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/navigation/navigation_routes.dart';
import 'package:movies/ui/pages/home_page/bloc/genres_bloc.dart';
import 'package:movies/ui/pages/home_page/bloc/genres_state.dart';
import 'package:movies/ui/widgets/favourites_button.dart';
import 'package:movies/ui/widgets/movie_genre_item.dart';

class MovieListItem extends StatefulWidget {
  final Movie movie;

  const MovieListItem({Key? key, required this.movie}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MovieListItemState();
}

class _MovieListItemState extends State<MovieListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: widget.movie.imageUrl(),
                width: 100,
                height: 100,
                fit: BoxFit.cover),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title ?? "-",
                    style: const TextStyle(
                      color: Color(MovieColor.colorText),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SvgPicture.asset(MovieSvgIcons.star),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${widget.movie.voteAverage}/10 IMDb',
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
                  const SizedBox(height: 5),
                  _setGenres(widget.movie.genreIds)
                ],
              ),
            ),
            FavouritesButton(movie: widget.movie)
          ],
        ),
      ),
      onTap: () => {context.pushNamed(movieRouteName, extra: widget.movie.id)},
    );
  }

  Widget _setGenres(List<int>? genreIds) {
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
}
