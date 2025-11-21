import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/get_all_top_rated_tv_shows_usecase.dart';

part 'top_rated_tv_shows_event.dart';
part 'top_rated_tv_shows_state.dart';

class TopRatedTvShowsBloc
    extends Bloc<TopRatedTvShowsEvent, TopRatedTvShowsState> {
  TopRatedTvShowsBloc(this._getAllTopRatedTvShowsUsecase)
    : super(TopRatedTvShowsState()) {
    on<GetTopRatedTvShowsEvent>(_getTopRatedTvShows);
    on<FetchMoreTopRatedTvShowsEvent>(_getTopRatedTvShows);
  }

  final GetAllTopRatedTvShowsUsecase _getAllTopRatedTvShowsUsecase;
  int page = 1;

  Future<void> _getTopRatedTvShows(
    TopRatedTvShowsEvent event,
    Emitter<TopRatedTvShowsState> emit,
  ) async {
    emitLoading(event, emit);

    final result = await _getAllTopRatedTvShowsUsecase(page);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: _isFetchMoreEvent(event)
              ? GetAllRequestStatus.fetchMoreError
              : GetAllRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        page++;
        emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            tvShows: state.tvShows + r,
          ),
        );
      },
    );
  }

  void emitLoading(
    TopRatedTvShowsEvent event,
    Emitter<TopRatedTvShowsState> emit,
  ) {
    if (state.status != GetAllRequestStatus.loading &&
        state.status != GetAllRequestStatus.loaded &&
        !_isFetchMoreEvent(event)) {
      emit(state.copyWith(status: GetAllRequestStatus.loading));
    }
  }

  bool _isFetchMoreEvent(TopRatedTvShowsEvent event) =>
      event is FetchMoreTopRatedTvShowsEvent;
}
