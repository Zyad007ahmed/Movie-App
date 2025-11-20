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
import '../controllers/top_rated_tv_shows_bloc/top_rated_tv_shows_bloc.dart';

class TopRatedTvShowsView extends StatelessWidget {
  const TopRatedTvShowsView({super.key});

  @override
  Widget build(BuildContext context) {
    _requestTopRatedTvShows();

    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.topRatedShows),
      body: BlocBuilder<TopRatedTvShowsBloc, TopRatedTvShowsState>(
        builder: (context, state) {
          switch (state.status) {
            case GetAllRequestStatus.loading:
              return const LoadingIndicator();
            case GetAllRequestStatus.loaded:
              return TopRatedTvShowsWidget(tvShows: state.tvShows);
            case GetAllRequestStatus.error:
              return ErrorScreen(
                onTryAgainPressed: () {
                  _requestTopRatedTvShows();
                },
              );
            case GetAllRequestStatus.fetchMoreError:
              return TopRatedTvShowsWidget(tvShows: state.tvShows);
          }
        },
      ),
    );
  }
}

void _requestTopRatedTvShows({bool isFetchMore = false}) {
  if (isFetchMore) {
    sl<TopRatedTvShowsBloc>().add(FetchMoreTopRatedTvShowsEvent());
  } else {
    sl<TopRatedTvShowsBloc>().add(GetTopRatedTvShowsEvent());
  }
}

class TopRatedTvShowsWidget extends StatelessWidget {
  const TopRatedTvShowsWidget({super.key, required this.tvShows});

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
        _requestTopRatedTvShows(isFetchMore: true);
      },
    );
  }
}
