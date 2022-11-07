import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/blocs/genres_bloc/genres_bloc.dart';
import 'package:movies/blocs/genres_bloc/genres_event.dart';
import 'package:movies/blocs/network_connection_bloc/network_connection_bloc.dart';
import 'package:movies/blocs/network_connection_bloc/network_connection_event.dart';
import 'package:movies/blocs/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movies/blocs/popular_movies_bloc/popular_movies_event.dart';
import 'package:movies/domain/genre.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/navigation/nav_router.dart';
import 'package:movies/repository/api_repository.dart';
import 'package:movies/repository/repository_manager.dart';

void main() async {
  await Hive.initFlutter();
  final apiRepository = ApiRepository(repositoryManager: RepositoryManager());
  Hive.registerAdapter(GenreAdapter());
  Hive.registerAdapter(MovieAdapter());
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
            create: (context) => GenresBloc(apiRepository: apiRepository)
              ..add(
                GetMovieGenres(),
              ),
          ),
          BlocProvider<PopularMoviesBloc>(
            create: (context) => PopularMoviesBloc(apiRepository: apiRepository)
              ..add(
                GetPopularMovies(),
              ),
          ),
        ],
        child: MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final appRouter = NavRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: appRouter.router.routeInformationParser,
      routerDelegate: appRouter.router.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
    // return const MaterialApp(
    //   title: 'Movies',
    //   home: HomePage(),
    //   debugShowCheckedModeBanner: false,
    // );
  }
}
