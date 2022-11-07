import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/blocs/genres_bloc/genres_bloc.dart';
import 'package:movies/blocs/genres_bloc/genres_event.dart';
import 'package:movies/blocs/network_connection_bloc/network_connection_bloc.dart';
import 'package:movies/blocs/network_connection_bloc/network_connection_event.dart';
import 'package:movies/blocs/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movies/blocs/popular_movies_bloc/popular_movies_event.dart';
import 'package:movies/pages/home_page.dart';
import 'package:movies/repository/api_repository.dart';
import 'package:movies/repository/repository_manager.dart';

void main() async {
  await Hive.initFlutter();
  final _apiRepository = ApiRepository();
  runApp(RepositoryProvider(
      create: (context) => RepositoryManager(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NetworkConnectionBloc>(
            create: (context) => NetworkConnectionBloc()
              ..add(
                CheckNetworkConnection(),
              ),
          ),
          BlocProvider<GenresBloc>(
            create: (context) => GenresBloc(apiRepository: _apiRepository)
              ..add(
                GetMovieGenres(),
              ),
          ),
          BlocProvider<PopularMoviesBloc>(
            create: (context) =>
                PopularMoviesBloc(apiRepository: _apiRepository)
                  ..add(
                    GetPopularMovies(),
                  ),
          ),
        ],
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movies',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
