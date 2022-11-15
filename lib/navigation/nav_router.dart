import 'package:go_router/go_router.dart';
import 'package:movies/navigation/navigation_routes.dart';
import 'package:movies/ui/pages/home_page/home_page.dart';
import 'package:movies/ui/pages/movie_details/movie_details_page.dart';

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
                  child: MovieDetailsPage(movieId: state.extra as int)))
        ]);
  }
}
