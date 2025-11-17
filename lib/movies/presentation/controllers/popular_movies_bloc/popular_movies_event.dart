part of 'popular_movies_bloc.dart';

sealed class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMoviesEvent extends PopularMoviesEvent{}

class FetchMorePopularMoviesEvent extends PopularMoviesEvent{}
