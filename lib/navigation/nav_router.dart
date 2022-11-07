import 'package:go_router/go_router.dart';
import 'package:movies/navigation/navigation_routes.dart';
import 'package:movies/ui/pages/home_page.dart';
import 'package:movies/ui/pages/movie_details/movie_details.dart';

class NavRouter {
  late GoRouter _router;

  get router => _router;

  NavRouter() {
    initRouter();
  }

  void initRouter() {
    _router = GoRouter(
        initialLocation: mainRoute,
        debugLogDiagnostics: true,
        routes: <GoRoute>[
          GoRoute(
              name: mainRouteName,
              path: mainRoute,
              pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  name: mainRouteName,
                  child: const HomePage())),
          GoRoute(
              name: movieRouteName,
              path: movieRoute,
              pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  name: movieRouteName,
                  child: MovieDetails(movieId: state.extra as int)))
        ]);
  }
}
