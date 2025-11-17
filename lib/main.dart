import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/resources/app_router.dart';
import 'core/resources/app_strings.dart';
import 'movies/presentation/controllers/movie_details_bloc/movie_details_bloc.dart';
import 'movies/presentation/controllers/movies_bloc/movies_bloc.dart';
import 'movies/presentation/controllers/popular_movies_bloc/popular_movies_bloc.dart';
import 'movies/presentation/controllers/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'watchlist/data/models/watchlist_item_model.dart';

import 'core/resources/app_theme.dart';
import 'core/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadEnvVariables();

  await prepareHive();

  intializeServiceLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<MoviesBloc>()..add(GetMoviesEvent()),
        ),
        BlocProvider(create: (context) => sl<MovieDetailsBloc>()),
        BlocProvider(
          create: (context) =>
              sl<PopularMoviesBloc>()..add(GetPopularMoviesEvent()),
        ),
        BlocProvider(
          create: (context) =>
              sl<TopRatedMoviesBloc>()..add(GetTopRatedMoviesEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

void intializeServiceLocator() {
  ServiceLocator.init();
}

Future<void> prepareHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WatchlistItemMoodelAdapter());
  await Hive.openBox<WatchlistItemModel>('items');
}

Future<void> loadEnvVariables() async {
  await dotenv.load();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: getApplicationTheme(),
      routerConfig: AppRouter.router,
    );
  }
}
