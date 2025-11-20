part of 'top_rated_tv_shows_bloc.dart';

sealed class TopRatedTvShowsEvent extends Equatable {
  const TopRatedTvShowsEvent();

  @override
  List<Object> get props => [];
}

class GetTopRatedTvShowsEvent extends TopRatedTvShowsEvent{}

class FetchMoreTopRatedTvShowsEvent extends TopRatedTvShowsEvent{}
