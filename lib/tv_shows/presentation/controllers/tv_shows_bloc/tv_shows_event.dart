part of 'tv_shows_bloc.dart';

sealed class TvShowsEvent extends Equatable {
  const TvShowsEvent();

  @override
  List<Object> get props => [];
}

class GetTvShowsEvent extends TvShowsEvent{}
