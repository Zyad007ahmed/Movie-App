import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/domain/entities/media_details.dart';
import '../../../core/presentation/components/details_card.dart';
import '../../../core/presentation/components/error_screen.dart';
import '../../../core/presentation/components/loading_indicator.dart';
import '../../../core/presentation/components/section_title.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/app_values.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/functions.dart';
import '../components/episode_card.dart';
import '../components/seasons_section.dart';
import '../components/tv_show_card_details.dart';

import '../controllers/tv_show_details_bloc/tv_show_details_bloc.dart';

class TvShowDetailsView extends StatelessWidget {
  TvShowDetailsView({super.key, required this.tvShowId});

  final int tvShowId;

  final bloc = TvShowDetailsBloc(sl(), sl());

  @override
  Widget build(BuildContext context) {
    _requestTvShowDetails();

    return Scaffold(
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
          builder: (context, state) {
            switch (state.tvShowDetailsStatus) {
              case RequestStatus.loading:
                return const LoadingIndicator();
              case RequestStatus.loaded:
                return TvShowDetailsWidget(tvShowDetails: state.tvShowDetails!);
              case RequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    _requestTvShowDetails();
                  },
                );
            }
          },
        ),
      ),
    );
  }

  void _requestTvShowDetails() => bloc.add(GetTvShowDetailsEvent(tvShowId));
}

class TvShowDetailsWidget extends StatelessWidget {
  const TvShowDetailsWidget({super.key, required this.tvShowDetails});

  final MediaDetails tvShowDetails;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTvShowDetailsCard(),
          getOverviewSection(tvShowDetails.overview),
          ..._buildLastEpisodeOnAirSection(),
          ..._buildSeasonsSection(),
          getSimilarSection(tvShowDetails.similar),
          const SizedBox(height: AppSize.s8),
        ],
      ),
    );
  }

  List<Widget> _buildLastEpisodeOnAirSection() {
    return [
      const SectionTitle(title: AppStrings.lastEpisodeOnAir),
      EpisodeCard(episode: tvShowDetails.lastEpisodeToAir!),
    ];
  }

  List<Widget> _buildSeasonsSection() {
    return [
      const SectionTitle(title: AppStrings.seasons),
      SeasonsSection(
        tmdbID: tvShowDetails.tmdbId,
        seasons: tvShowDetails.seasons!,
      ),
    ];
  }

  DetailsCard _buildTvShowDetailsCard() {
    return DetailsCard(
      mediaDetails: tvShowDetails,
      detailsWidget: TvShowCardDetails(
        genres: tvShowDetails.genres,
        lastEpisode: tvShowDetails.lastEpisodeToAir!,
        seasons: tvShowDetails.seasons!,
      ),
    );
  }
}
