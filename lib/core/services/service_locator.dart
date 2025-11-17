import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

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

    //todo : hive

    // Data source
    sl.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImp(sl()),
    );

    // Repository
    sl.registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(sl()),
    );

    // Use Cases
    sl.registerLazySingleton(() => GetMovieDetailsUsecase(sl()));
    sl.registerLazySingleton(() => GetMoviesUsecase(sl()));
    sl.registerLazySingleton(() => GetAllPopularMoviesUsecase(sl()));
    sl.registerLazySingleton(() => GetAllTopRatedMoviesUsecase(sl()));

    // Bloc
    sl.registerLazySingleton(() => MoviesBloc(sl()));
    sl.registerLazySingleton(() => MovieDetailsBloc(sl()));
    sl.registerLazySingleton(() => PopularMoviesBloc(sl()));
    sl.registerLazySingleton(() => TopRatedMoviesBloc(sl()));
  }
}
