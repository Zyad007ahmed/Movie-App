part of 'tv_show_details_bloc.dart';

sealed class TvShowDetailsEvent extends Equatable {
  const TvShowDetailsEvent();
}

class GetTvShowDetailsEvent extends TvShowDetailsEvent {
  final int id;

  const GetTvShowDetailsEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetSeasonDetailsEvent extends TvShowDetailsEvent {
  final int id;
  final int seasonNumber;

  const GetSeasonDetailsEvent(this.id, this.seasonNumber);

  @override
  List<Object?> get props => [id, seasonNumber];
}
