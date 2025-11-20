import '../../../core/domain/entities/media_details.dart';
import '../../../core/utils/functions.dart';
import 'episode_model.dart';
import 'season_model.dart';
import 'tv_show_model.dart';


// ignore: must_be_immutable
class TvShowDetailsModel extends MediaDetails {
  TvShowDetailsModel({
    required super.tmdbId,
    required super.title,
    required super.posterUrl,
    required super.backdropUrl,
    required super.releaseDate,
    required super.lastEpisodeToAir,
    required super.genres,
    required super.overview,
    required super.voteAverage,
    required super.voteCount,
    required super.trailerUrl,
    required super.numberOfSeasons,
    required super.seasons,
    required super.similar,
  });

  factory TvShowDetailsModel.fromJson(Map<String, dynamic> json) {
    return TvShowDetailsModel(
      tmdbId: json['id'],
      title: json['name'],
      posterUrl: getPosterUrl(json['poster_path']),
      backdropUrl: getBackdropUrl(json['backdrop_path']),
      releaseDate: getDate(json['first_air_date']),
      lastEpisodeToAir: EpisodeModel.fromJson(json['last_episode_to_air']),
      genres: getGenres(json['genres']),
      numberOfSeasons: json['number_of_seasons'],
      voteAverage:
          double.parse((json['vote_average'] as double).toStringAsFixed(1)),
      voteCount: getVotesCount(json['vote_count']),
      overview: json['overview'],
      trailerUrl: getTrailerUrl(json),
      seasons: List<SeasonModel>.from(
        ((json['seasons'] as List)
            .where((e) => e['name'] != 'Specials')
            .map((e) => SeasonModel.fromJson(e))),
      ),
      similar: List<TvShowModel>.from((json['similar']['results'] as List)
          .map((e) => TvShowModel.fromJson(e))),
    );
  }
}
