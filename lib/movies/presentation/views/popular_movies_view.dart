import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/domain/entities/media.dart';
import '../../../core/presentation/components/custom_app_bar.dart';
import '../../../core/presentation/components/error_screen.dart';
import '../../../core/presentation/components/loading_indicator.dart';
import '../../../core/presentation/components/vertical_listview.dart';
import '../../../core/presentation/components/vertical_listview_card.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/enums.dart';
import '../controllers/popular_movies_bloc/popular_movies_bloc.dart';

class PopularMoviesView extends StatelessWidget {
  const PopularMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    _requestPopularMovies();

    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.popularMovies),
      body: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
        builder: (context, state) {
          switch (state.status) {
            case GetAllRequestStatus.loading:
              return const LoadingIndicator();
            case GetAllRequestStatus.loaded:
            case GetAllRequestStatus.fetchMoreError:
              return PopularMoviesWidget(movies: state.movies);
            case GetAllRequestStatus.error:
              return ErrorScreen(
                onTryAgainPressed: () {
                  _requestPopularMovies();
                },
              );
          }
        },
      ),
    );
  }
}

void _requestPopularMovies({bool isFetchMore = false}) {
  if (isFetchMore) {
    sl<PopularMoviesBloc>().add(FetchMorePopularMoviesEvent());
  } else {
    sl<PopularMoviesBloc>().add(GetPopularMoviesEvent());
  }
}

class PopularMoviesWidget extends StatelessWidget {
  final List<Media> movies;

  const PopularMoviesWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return VerticalListView(
      itemCount: movies.length + 1,
      itemBuilder: (context, index) {
        if (index < movies.length) {
          return VerticalListViewCard(media: movies[index]);
        } else {
          return const LoadingIndicator();
        }
      },
      addEvent: () {
        _requestPopularMovies(isFetchMore: true);
      },
    );
  }
}
