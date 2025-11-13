import 'package:equatable/equatable.dart';
import 'package:movie_app/tv_shows/domain/entities/episode.dart';

class SeasonDetails extends Equatable{
  final List<Episode> episodes;

  const SeasonDetails({required this.episodes});
  
  @override
  List<Object?> get props => [episodes];
}