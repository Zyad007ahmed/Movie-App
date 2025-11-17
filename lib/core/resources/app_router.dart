import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../presentation/pages/main_page.dart';
import 'app_routes.dart';
import '../../movies/presentation/views/movie_details_view.dart';
import '../../movies/presentation/views/popular_movies_view.dart';
import '../../movies/presentation/views/top_rated_movies_view.dart';

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
            routes: [
              GoRoute(
                name: AppRoutes.movieDetailsRoute,
                path: movieDetailsPath,
                pageBuilder: (context, state) => CupertinoPage(
                  child: MovieDetailsView(
                    movieId: int.parse(state.pathParameters['movieId']!),
                  ),
                ),
              ),
              GoRoute(
                name: AppRoutes.popularMoviesRoute,
                path: popularMoviesPath,
                pageBuilder: (context, state) =>
                    const CupertinoPage(child: PopularMoviesView()),
              ),
              GoRoute(
                name: AppRoutes.topRatedMoviesRoute,
                path: topRatedMoviesPath,
                pageBuilder: (context, state) =>
                    const CupertinoPage(child: TopRatedMoviesView()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
