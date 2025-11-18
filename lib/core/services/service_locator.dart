import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/watchlist/data/datasource/watchlist_local_data_source.dart';
import 'package:movie_app/watchlist/data/models/watchlist_item_model.dart';
import 'package:movie_app/watchlist/data/repository/watchlist_repository_impl.dart';
import 'package:movie_app/watchlist/domain/usecases/get_watchlist_items_use_case.dart';

import '../../movies/data/datasource/movies_remote_data_source.dart';
import '../../movies/data/repository/movies_repository_impl.dart';
import '../../movies/domain/repository/movies_repository.dart';
import '../../movies/domain/usecases/get_all_popular_movies_usecase.dart';
import '../../movies/domain/usecases/get_all_top_rated_movies_usecase.dart';
import '../../movies/domain/usecases/get_movie_details_usecase.dart';
import '../../movies/domain/usecases/get_movies_usecase.dart';
import '../../movies/presentation/controllers/movie_details_bloc/movie_details_bloc.dart';
import '../../movies/presentation/controllers/movies_bloc/movies_bloc.dart';
import '../../movies/presentation/controllers/popular_movies_bloc/popular_movies_bloc.dart';
import '../../movies/presentation/controllers/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import '../../watchlist/domain/repository/watchlist_repository.dart';
import '../../watchlist/domain/usecases/add_watchlist_item_use_case.dart';
import '../../watchlist/domain/usecases/is_bookmarked_use_case.dart';
import '../../watchlist/domain/usecases/remove_watchlist_item_usecase.dart';
import '../../watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';
import '../config/env.dart';

final sl = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();

  static void init() {
    sl.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: Env.baseUrl,
          queryParameters: {'api_key': Env.apiKey},
        ),
      ),
    );

    sl.registerLazySingleton<Box<WatchlistItemModel>>(
      () => Hive.box<WatchlistItemModel>('items'),
    );

    // Data source
    sl.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImp(sl()),
    );
    sl.registerLazySingleton<WatchlistLocalDataSource>(
      () => WatchlistLocalDataSourceImpl(sl()),
    );

    // Repository
    sl.registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<WatchlistRepository>(
      () => WatchlistRepositoryImpl(sl()),
    );

    // Use Cases
    // movies feature
    sl.registerLazySingleton(() => GetMovieDetailsUsecase(sl()));
    sl.registerLazySingleton(() => GetMoviesUsecase(sl()));
    sl.registerLazySingleton(() => GetAllPopularMoviesUsecase(sl()));
    sl.registerLazySingleton(() => GetAllTopRatedMoviesUsecase(sl()));
    // watchlist feature
    sl.registerLazySingleton(() => GetWatchlistItemsUseCase(sl()));
    sl.registerLazySingleton(() => AddWatchlistItemUseCase(sl()));
    sl.registerLazySingleton(() => RemoveWatchlistItemUseCase(sl()));
    sl.registerLazySingleton(() => IsBookmarkedUseCase(sl()));

    // Bloc
    // movies feature
    sl.registerLazySingleton(() => MoviesBloc(sl()));
    sl.registerLazySingleton(() => MovieDetailsBloc(sl()));
    sl.registerLazySingleton(() => PopularMoviesBloc(sl()));
    sl.registerLazySingleton(() => TopRatedMoviesBloc(sl()));
    // watchlist feature
    sl.registerLazySingleton(() => WatchlistBloc(sl(), sl(), sl(), sl()));
  }
}
