import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/ui/pages/favourites_widget/bloc/favourites_bloc.dart';
import 'package:movies/ui/pages/favourites_widget/bloc/favourites_event.dart';
import 'package:movies/ui/pages/favourites_widget/bloc/favourites_state.dart';
import 'package:movies/ui/widgets/loading_indicator.dart';
import 'package:movies/ui/widgets/movie_list_item.dart';

class FavouritesWidget extends StatefulWidget {
  const FavouritesWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavouritesWidgetState();
}

class _FavouritesWidgetState extends State<FavouritesWidget> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavouritesBloc>(context).add(GetFavourites());
    return _buildPopularMoviesList();
  }

  Widget _buildPopularMoviesList() {
    return BlocBuilder<FavouritesBloc, FavouritesState>(
      builder: (context, state) {
        if (state is FavouritesInitial) {
          return _buildLoading();
        } else if (state is FavouritesLoading) {
          return _buildLoading();
        } else if (state is FavouritesLoaded) {
          return _buildCard(context, state.favourites);
        }
        // else if (state is CovidError) {
        //   return Container();
        // }
        else {
          return Container();
        }
      },
    );
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
