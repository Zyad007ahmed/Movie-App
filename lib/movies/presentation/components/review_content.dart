import 'package:flutter/material.dart';
import '../../../core/resources/app_values.dart';
import 'avatar.dart';

import '../../domain/entities/review.dart';

class ReviewContent extends StatelessWidget {
  final Review review;

  const ReviewContent({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p6),
                  child: Avatar(avatarUrl: review.avatarUrl),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.authorName, style: textTheme.bodyMedium),
                    Text(review.authorUserName, style: textTheme.bodyLarge),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppPadding.p10),
              child: Text(review.content, style: textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
