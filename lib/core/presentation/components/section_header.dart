import 'package:flutter/material.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_values.dart';

import '../../resources/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Function() onSeeAllTap;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.p4,
        horizontal: AppPadding.p16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textTheme.titleSmall),
          InkWell(
            onTap: onSeeAllTap,
            child: Row(
              children: [
                Text(AppStrings.seeAll, style: textTheme.bodyLarge),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppSize.s12,
                  color: AppColors.primaryText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
