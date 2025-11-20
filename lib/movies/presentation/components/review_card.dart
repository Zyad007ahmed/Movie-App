import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_values.dart';
import '../../../core/utils/functions.dart';
import '../../domain/entities/review.dart';
import 'avatar.dart';
import 'review_content.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => _onCardTap(context),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p12),
        width: AppSize.s240,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _getReviewerSection(textTheme),
            _getReviewContent(textTheme),
            _getRatingBarIndicatorAndElapsedTimeSection(textTheme),
          ],
        ),
      ),
    );
  }

  Row _getRatingBarIndicatorAndElapsedTimeSection(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _getRatingBarIndicator(review.rating),
        _getElapsedTime(textTheme),
      ],
    );
  }

  Text _getReviewContent(TextTheme textTheme) {
    return Text(
      review.content,
      style: textTheme.bodyLarge,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Row _getReviewerSection(TextTheme textTheme) {
    return Row(
      children: [
        _getAvatar(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getReviewerName(textTheme),
              _getReviewerUserName(textTheme),
            ],
          ),
        ),
      ],
    );
  }

  Text _getElapsedTime(TextTheme textTheme) =>
      Text(review.elapsedTime, style: textTheme.bodySmall);

  Text _getReviewerUserName(TextTheme textTheme) {
    return Text(
      review.authorUserName,
      style: textTheme.bodyLarge,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Text _getReviewerName(TextTheme textTheme) {
    return Text(
      review.authorName,
      style: textTheme.bodyMedium,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Padding _getAvatar() {
    return Padding(
      padding: const EdgeInsets.only(right: AppPadding.p6),
      child: Avatar(avatarUrl: review.avatarUrl),
    );
  }

  void _onCardTap(BuildContext context) {
    return showCustomBottomSheet(
      context: context,
      child: ReviewContent(review: review),
    );
  }

  Widget _getRatingBarIndicator(double rating) {
    if (rating != -1) {
      return RatingBarIndicator(
        rating: rating,
        itemSize: AppSize.s16,
        unratedColor: AppColors.primaryText,
        itemBuilder: (context, index) => const Icon(
          Icons.star_rate_rounded,
          color: AppColors.ratingIconColor,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
