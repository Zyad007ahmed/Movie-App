import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/services/service_locator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';
import '../../domain/entities/media.dart';
import '../../domain/entities/media_details.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_values.dart';
import '../../utils/enums.dart';
import 'slider_card_image.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    required this.mediaDetails,
    required this.detailsWidget,
    super.key,
  });

  final MediaDetails mediaDetails;
  final Widget detailsWidget;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    _checkIfMovieBookmarked();

    return SafeArea(
      child: Stack(
        children: [
          _getBackdropImage(),
          _getDetailsAndTrailerSection(size, textTheme),
          _getBackButtonAndBookmarkSection(context),
        ],
      ),
    );
  }

  Padding _getDetailsAndTrailerSection(Size size, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: SizedBox(
        height: size.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppPadding.p8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getTitle(textTheme),
                    _getMovieDetails(),
                    _getVoteAverageAndVoteCount(textTheme),
                  ],
                ),
              ),
              _getTrailerPlayerIfPossible(),
            ],
          ),
        ),
      ),
    );
  }

  Padding _getBackButtonAndBookmarkSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p16,
        right: AppPadding.p16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_getBackButton(context), _getBookmark()],
      ),
    );
  }

  InkWell _getBackButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.iconContainerColor,
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.secondaryText,
          size: AppSize.s20,
        ),
      ),
    );
  }

  InkWell _getBookmark() {
    return InkWell(
      onTap: () {
        mediaDetails.isBookmarked
            ? sl<WatchlistBloc>().add(
                RemoveWatchListItemEvent(index: mediaDetails.id!),
              )
            : sl<WatchlistBloc>().add(
                AddWatchListItemEvent(
                  media: Media.fromMediaDetails(mediaDetails),
                ),
              );
      },
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.iconContainerColor,
        ),
        child: BlocConsumer<WatchlistBloc, WatchlistState>(
          listener: (context, state) {
            final action = state.actionStatus;
            if (action == BookmarkStatus.added) {
              mediaDetails.id = state.id;
              mediaDetails.isBookmarked = true;
            } else if (action == BookmarkStatus.removed) {
              mediaDetails.id = null;
              mediaDetails.isBookmarked = false;
            } else if (action == BookmarkStatus.exists && state.id != -1) {
              mediaDetails.id = state.id;
              mediaDetails.isBookmarked = true;
            }
          },
          builder: (context, state) {
            return Icon(
              Icons.bookmark_rounded,
              color: mediaDetails.isBookmarked
                  ? AppColors.primary
                  : AppColors.secondaryText,
              size: AppSize.s20,
            );
          },
        ),
      ),
    );
  }

  Widget _getTrailerPlayerIfPossible() {
    if (mediaDetails.trailerUrl.isNotEmpty) {
      return InkWell(
        onTap: () async {
          final url = Uri.parse(mediaDetails.trailerUrl);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        },
        child: Container(
          height: AppSize.s40,
          width: AppSize.s40,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.play_arrow_rounded,
            color: AppColors.secondaryText,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Row _getVoteAverageAndVoteCount(TextTheme textTheme) {
    return Row(
      children: [
        const Icon(
          Icons.star_rate_rounded,
          color: AppColors.ratingIconColor,
          size: AppSize.s18,
        ),
        Text('${mediaDetails.voteAverage} ', style: textTheme.bodyMedium),
        Text(mediaDetails.voteCount, style: textTheme.bodySmall),
      ],
    );
  }

  Padding _getMovieDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p4, bottom: AppPadding.p6),
      child: detailsWidget,
    );
  }

  Text _getTitle(TextTheme textTheme) {
    return Text(mediaDetails.title, maxLines: 2, style: textTheme.titleMedium);
  }

  SliderCardImage _getBackdropImage() =>
      SliderCardImage(imageUrl: mediaDetails.backdropUrl);

  void _checkIfMovieBookmarked() {
    sl<WatchlistBloc>().add(CheckBookmarkEvent(tmdbId: mediaDetails.tmdbId));
  }
}
