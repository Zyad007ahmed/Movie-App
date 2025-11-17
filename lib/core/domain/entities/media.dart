import 'package:equatable/equatable.dart';
import 'media_details.dart';

class Media extends Equatable {
  final int tmdbId;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final double voteAverage;
  final String releaseDate;
  final String overview;
  final bool isMovie;

  const Media({
    required this.tmdbId,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
    required this.isMovie,
  });

  factory Media.fromMediaDetails(MediaDetails mediaDetails) {
    return Media(
      tmdbId: mediaDetails.tmdbId,
      title: mediaDetails.title,
      posterUrl: mediaDetails.posterUrl,
      backdropUrl: mediaDetails.backdropUrl,
      voteAverage: mediaDetails.voteAverage,
      releaseDate: mediaDetails.releaseDate,
      overview: mediaDetails.overview,
      isMovie: mediaDetails.lastEpisodeToAir == null,
    );
  }

  @override
  List<Object?> get props => [
        tmdbId,
        title,
        posterUrl,
        backdropUrl,
        voteAverage,
        releaseDate,
        overview,
        isMovie,
      ];
}
