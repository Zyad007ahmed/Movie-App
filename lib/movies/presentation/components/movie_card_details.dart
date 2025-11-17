import 'package:flutter/material.dart';
import '../../../core/domain/entities/media_details.dart';
import '../../../core/presentation/components/circle_dot.dart';

class MovieCardDetails extends StatelessWidget {
  final MediaDetails movieDetails;

  const MovieCardDetails({super.key, required this.movieDetails});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (movieDetails.releaseDate.isNotEmpty &&
        movieDetails.genres.isNotEmpty &&
        movieDetails.runtime!.isNotEmpty) {
      return Row(
        children: [
          Text(
            movieDetails.releaseDate.split(',')[1],
            style: textTheme.bodyLarge,
          ),
          const CircleDot(),
          Text(
            movieDetails.genres,
            style: textTheme.bodyLarge,
          ),
          const CircleDot(),
          Text(
            movieDetails.runtime!,
            style: textTheme.bodyLarge,
          ),
          const CircleDot(),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
