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
import '../controllers/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';

class PopularTvShowsView extends StatelessWidget {
  const PopularTvShowsView({super.key});

  @override
  Widget build(BuildContext context) {
    _requestPopularTvShows();

    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.popularShows),
      body: BlocBuilder<PopularTvShowsBloc, PopularTvShowsState>(
        builder: (context, state) {
          switch (state.status) {
            case GetAllRequestStatus.loading:
              return const LoadingIndicator();
            case GetAllRequestStatus.loaded:
              return PopularTvShowsWidget(tvShows: state.tvShows);
            case GetAllRequestStatus.error:
              return ErrorScreen(
                onTryAgainPressed: () {
                  _requestPopularTvShows();
                },
              );
            case GetAllRequestStatus.fetchMoreError:
              return PopularTvShowsWidget(tvShows: state.tvShows);
          }
        },
      ),
    );
  }
}

void _requestPopularTvShows({bool isFetchMore = false}) {
  if (isFetchMore) {
    sl<PopularTvShowsBloc>().add(FetchMorePopularTvShowsEvent());
  } else {
    sl<PopularTvShowsBloc>().add(GetPopularTvShowsEvent());
  }
}

class PopularTvShowsWidget extends StatelessWidget {
  const PopularTvShowsWidget({super.key, required this.tvShows});

  final List<Media> tvShows;

  @override
  Widget build(BuildContext context) {
    return VerticalListView(
      itemCount: tvShows.length + 1,
      itemBuilder: (context, index) {
        if (index < tvShows.length) {
          return VerticalListViewCard(media: tvShows[index]);
        } else {
          return const LoadingIndicator();
        }
      },
      addEvent: () {
        _requestPopularTvShows(isFetchMore: true);
      },
    );
  }
}
