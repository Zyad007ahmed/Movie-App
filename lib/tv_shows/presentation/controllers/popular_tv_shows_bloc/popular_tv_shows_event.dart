part of 'popular_tv_shows_bloc.dart';

sealed class PopularTvShowsEvent extends Equatable {
  const PopularTvShowsEvent();

  @override
  List<Object> get props => [];
}

class GetPopularTvShowsEvent extends PopularTvShowsEvent {}

class FetchMorePopularTvShowsEvent extends PopularTvShowsEvent {}
