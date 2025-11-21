import 'package:flutter/material.dart';

import '../../domain/entities/media.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_values.dart';
import '../../utils/functions.dart';
import 'image_with_shimmer.dart';

class VerticalListViewCard extends StatelessWidget {
  const VerticalListViewCard({super.key, required this.media});

  final Media media;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        navigateToDetailsView(context, media.tmdbId, media.isMovie);
      },
      child: Container(
        height: AppSize.s175,
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getMediaImage(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getTitle(textTheme),
                  Row(
                    children: [
                      _getReleaseDateIfPossible(textTheme),
                      ..._getVoteAverage(textTheme),
                    ],
                  ),
                  _getOverview(textTheme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _getOverview(TextTheme textTheme) {
    return Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p14),
                  child: Text(
                    media.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge,
                  ),
                );
  }

  Padding _getTitle(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p6),
      child: Text(
        media.title,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: textTheme.titleSmall,
      ),
    );
  }

  Padding _getMediaImage() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: ImageWithShimmer(
          imageUrl: media.posterUrl,
          width: AppSize.s110,
          height: double.infinity,
        ),
      ),
    );
  }

  Widget _getReleaseDateIfPossible(TextTheme textTheme) {
    if (media.releaseDate.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(right: AppPadding.p12),
        child: Text(
          media.releaseDate.split(', ')[1],
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  List<Widget> _getVoteAverage(TextTheme textTheme) {
    return [
      const Icon(
        Icons.star_rate_rounded,
        color: AppColors.ratingIconColor,
        size: AppSize.s18,
      ),
      Text(media.voteAverage.toString(), style: textTheme.bodyLarge),
    ];
  }
}
