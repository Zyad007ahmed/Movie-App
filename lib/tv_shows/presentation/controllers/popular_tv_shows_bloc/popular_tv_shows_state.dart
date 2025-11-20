part of 'popular_tv_shows_bloc.dart';

class PopularTvShowsState extends Equatable {
  final List<Media> tvShows;
  final GetAllRequestStatus status;
  final String message;

  const PopularTvShowsState({
    this.tvShows = const [],
    this.status = GetAllRequestStatus.loading,
    this.message = '',
  });
  
  PopularTvShowsState copyWith({
    List<Media>? tvShows,
    GetAllRequestStatus? status,
    String? message,
  }) {
    return PopularTvShowsState(
      tvShows: tvShows ?? this.tvShows,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        tvShows,
        status,
        message,
      ];
}

