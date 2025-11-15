import 'package:go_router/go_router.dart';
import 'package:movie_app/core/presentation/pages/main_page.dart';
import 'package:movie_app/core/resources/app_routes.dart';

import '../../movies/presentation/views/movies_view.dart';

const String moviesPath = '/movies';
const String movieDetailsPath = 'movieDetails/:movieId';
const String popularMoviesPath = 'popularMovies';
const String topRatedMoviesPath = 'topRatedMovies';
const String tvShowsPath = '/tvShows';
const String tvShowDetailsPath = 'tvShowDetails/:tvShowId';
const String popularTVShowsPath = 'popularTVShows';
const String topRatedTVShowsPath = 'topRatedTVShows';
const String searchPath = '/search';
const String watchlistPath = '/watchlist';

class AppRouter {
  AppRouter._();

  static GoRouter router = GoRouter(
    initialLocation: moviesPath,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            name: AppRoutes.moviesRoute,
            path: moviesPath,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MoviesView()),
            routes: [],
          ),
        ],
      ),
    ],
  );
}
