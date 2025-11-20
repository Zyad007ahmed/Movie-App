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
import '../controllers/top_rated_movies_bloc/top_rated_movies_bloc.dart';

class TopRatedMoviesView extends StatelessWidget {
  const TopRatedMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    _requestTopRatedMovies();

    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.topRatedMovies),
      body: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
        builder: (context, state) {
          switch (state.status) {
            case GetAllRequestStatus.loading:
              return const LoadingIndicator();
            case GetAllRequestStatus.loaded:
              return TopRatedMoviesWidget(movies: state.movies);
            case GetAllRequestStatus.error:
              return ErrorScreen(
                onTryAgainPressed: () {
                  _requestTopRatedMovies();
                },
              );
            case GetAllRequestStatus.fetchMoreError:
              return TopRatedMoviesWidget(movies: state.movies);
          }
        },
      ),
    );
  }
}

void _requestTopRatedMovies({bool isFetchMore = false}) {
  if (isFetchMore) {
    sl<TopRatedMoviesBloc>().add(FetchMoreTopRatedMoviesEvent());
  } else {
    sl<TopRatedMoviesBloc>().add(GetTopRatedMoviesEvent());
  }
}

class TopRatedMoviesWidget extends StatelessWidget {
  final List<Media> movies;

  const TopRatedMoviesWidget({super.key, required this.movies});

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
        _requestTopRatedMovies(isFetchMore: true);
      },
    );
  }
}
