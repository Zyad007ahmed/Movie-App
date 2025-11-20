part of 'top_rated_tv_shows_bloc.dart';

class TopRatedTvShowsState extends Equatable {
  final List<Media> tvShows;
  final GetAllRequestStatus status;
  final String message;

  const TopRatedTvShowsState({
    this.tvShows = const [],
    this.status = GetAllRequestStatus.loading,
    this.message = '',
  });

  TopRatedTvShowsState copyWith({
    List<Media>? tvShows,
    GetAllRequestStatus? status,
    String? message,
  }) {
    return TopRatedTvShowsState(
      tvShows: tvShows ?? this.tvShows,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [tvShows, status, message];
}
