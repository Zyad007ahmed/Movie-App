import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../search/presentation/views/search_view.dart';
import '../../tv_shows/presentation/views/popular_tv_shows_view.dart';
import '../../tv_shows/presentation/views/top_rated_tv_shows_view.dart';
import '../../tv_shows/presentation/views/tv_show_details_view.dart';
import '../../tv_shows/presentation/views/tv_shows_view.dart';
import '../../watchlist/presentation/views/watchlist_view.dart';
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
const String popularTvShowsPath = 'popularTvShows';
const String topRatedTvShowsPath = 'topRatedTvShows';
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
          GoRoute(
            name: AppRoutes.tvShowsRoute,
            path: tvShowsPath,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: TvShowsView()),
            routes: [
              GoRoute(
                name: AppRoutes.tvShowDetailsRoute,
                path: tvShowDetailsPath,
                pageBuilder: (context, state) => CupertinoPage(
                  child: TvShowDetailsView(
                    tvShowId: int.parse(state.pathParameters['tvShowId']!),
                  ),
                ),
              ),
              GoRoute(
                name: AppRoutes.topRatedTvShowsRoute,
                path: topRatedTvShowsPath,
                pageBuilder: (context, state) =>
                    const CupertinoPage(child: TopRatedTvShowsView()),
              ),
              GoRoute(
                name: AppRoutes.popularTvShowsRoute,
                path: popularTvShowsPath,
                pageBuilder: (context, state) =>
                    const CupertinoPage(child: PopularTvShowsView()),
              ),
            ],
          ),
          GoRoute(
            name: AppRoutes.watchlistRoute,
            path: watchlistPath,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: WatchlistView()),
          ),
          GoRoute(
            name: AppRoutes.searchRoute,
            path: searchPath,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SearchView()),
          ),
        ],
      ),
    ],
  );
}
