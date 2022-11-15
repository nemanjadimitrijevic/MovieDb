import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/movie.dart';
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
  List<Movie>? _movieList;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Movies repo cleaning is for testing purposes only
    // In production ready app, this line should be removed.
    RepositoryManager().moviesRepository.clear();
    BlocProvider.of<PopularMoviesBloc>(context)
      ..page = 1
      ..add(const GetPopularMovies(isLoadMore: false));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPopularMoviesList();
  }

  Widget _buildPopularMoviesList() {
    return BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
      builder: (context, state) {
        if (state is PopularMoviesInitial) {
          return _buildLoading();
        } else if (state is PopularMoviesLoading) {
          return _buildLoading();
        } else if (state is PopularMoviesLoaded) {
          _movieList = state.movies;
          BlocProvider.of<PopularMoviesBloc>(context).isFetching = false;
        } else if (state is PopularMoviesLoadMoreFinished) {
          if (state.movies != null && state.movies!.isNotEmpty) {
            _movieList = state.movies;
            BlocProvider.of<PopularMoviesBloc>(context).isFetching = false;
          }
        } else if (state is PopularMoviesError) {
          // TODO - error handling
          return Container();
        }
        return _buildList(context);
      },
    );
  }

  Widget _buildList(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.position.pixels &&
          !BlocProvider.of<PopularMoviesBloc>(context).isFetching) {
        BlocProvider.of<PopularMoviesBloc>(context)
          ..isFetching = true
          ..add(const GetPopularMovies(isLoadMore: true));
      }
    });
    return Stack(
      children: [
        ListView.builder(
          itemCount: _movieList?.length ?? 0,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return _movieList != null
                ? MovieListItem(movie: _movieList![index])
                : Container();
          },
        ),
        if (BlocProvider.of<PopularMoviesBloc>(context).isFetching) ...[
          Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Center(child: LoadingIndicator()))
        ]
      ],
    );
  }

  Widget _buildLoading() => LoadingIndicator();
}
