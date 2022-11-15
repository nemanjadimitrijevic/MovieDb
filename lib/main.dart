import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/domain/genre.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/navigation/nav_router.dart';
import 'package:movies/repository/api_repository.dart';
import 'package:movies/repository/repository_manager.dart';
import 'package:movies/ui/pages/favourites_widget/bloc/favourites_bloc.dart';
import 'package:movies/ui/pages/home_page/bloc/genres_bloc.dart';
import 'package:movies/ui/pages/home_page/bloc/genres_event.dart';
import 'package:movies/ui/pages/home_page/bloc/network_connection_bloc.dart';
import 'package:movies/ui/pages/home_page/bloc/network_connection_event.dart';
import 'package:movies/ui/pages/movie_details/bloc/movie_details_bloc.dart';
import 'package:movies/ui/pages/popular_movies_widget/bloc/popular_movies_bloc.dart';

void main() async {
  await Hive.initFlutter();
  final apiRepository = ApiRepository(repositoryManager: RepositoryManager());
  Hive.registerAdapter(GenreAdapter());
  Hive.registerAdapter(MovieAdapter());
  runZonedGuarded(
    () => runApp(RepositoryProvider(
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
              create: (context) =>
                  PopularMoviesBloc(apiRepository: apiRepository),
            ),
            BlocProvider<MovieDetailsBloc>(
              create: (context) =>
                  MovieDetailsBloc(apiRepository: apiRepository),
            ),
            BlocProvider<FavouritesBloc>(
              create: (context) => FavouritesBloc(apiRepository: apiRepository),
            ),
          ],
          child: MyApp(),
        ))),
    (error, stackTrace) {
      print(error.toString()); // This is the message I print
    },
  );
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
