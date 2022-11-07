import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/common/colors.dart';
import 'package:movies/common/icons.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/widgets/movie_genre_item.dart';

class MovieListItem extends StatefulWidget {
  final Movie movie;

  const MovieListItem({Key? key, required this.movie}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MovieListItemState();
}

class _MovieListItemState extends State<MovieListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.movie.imageUrl(),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Column(
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
              _setGenres(widget.movie.genreIds)
            ],
          )
        ],
      ),
    );
  }

  Widget _setGenres(List<int>? genreIds) {
    if (genreIds == null || genreIds.isEmpty) {
      return Container();
    }
    return MovieGenreItems(genreIds: genreIds);
  }
}
