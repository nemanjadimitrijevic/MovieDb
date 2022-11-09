import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/common/colors.dart';
import 'package:movies/common/icons.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/repository/repository_manager.dart';
import 'package:movies/ui/pages/favourites_widget/bloc/favourites_bloc.dart';
import 'package:movies/ui/pages/favourites_widget/bloc/favourites_event.dart';

class FavouritesButton extends StatefulWidget {
  final Movie movie;
  const FavouritesButton({Key? key, required this.movie}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavouritesButtonState();
}

class _FavouritesButtonState extends State<FavouritesButton> {
  var _isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RepositoryManager().favouritesRepository.getAll(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // Box<Movie>? favouritesBox;
        if (snapshot.hasData) {
          // favouritesBox = snapshot.data as List<Movie>?;
          final favourites = snapshot.data as List<Movie>;
          if (favourites
              .where((element) => element.id == widget.movie.id)
              .isNotEmpty) {
            _isFavourite = true;
          } else {
            _isFavourite = false;
          }
        }
        return InkWell(
            highlightColor: const Color(MovieColor.colorHighlight),
            onTap: () => {
                  setState(() {
                    if (_isFavourite) {
                      BlocProvider.of<FavouritesBloc>(context)
                          .add(DeleteFavoriteMovie(movieId: widget.movie.id));
                    } else {
                      BlocProvider.of<FavouritesBloc>(context)
                          .add(SaveFavoriteMovie(movie: widget.movie));
                    }
                  })
                },
            child: SvgPicture.asset(_isFavourite
                ? MovieSvgIcons.bookmarkActive
                : MovieSvgIcons.bookmark));
      },
    );
  }
}
