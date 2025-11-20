import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/get_all_popular_tv_shows_usecase.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../../core/utils/enums.dart';

part 'popular_tv_shows_event.dart';
part 'popular_tv_shows_state.dart';

class PopularTvShowsBloc
    extends Bloc<PopularTvShowsEvent, PopularTvShowsState> {
  PopularTvShowsBloc(this._getAllPopularTvShowsUsecase)
    : super(PopularTvShowsState()) {
    on<GetPopularTvShowsEvent>(_getPopularTvShows);
    on<FetchMorePopularTvShowsEvent>(_getPopularTvShows);
  }

  final GetAllPopularTvShowsUsecase _getAllPopularTvShowsUsecase;
  int page = 1;

  Future<void> _getPopularTvShows(
    PopularTvShowsEvent event,
    Emitter<PopularTvShowsState> emit,
  ) async {
    emitLoading(event, emit);

    final result = await _getAllPopularTvShowsUsecase(page);

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
    PopularTvShowsEvent event,
    Emitter<PopularTvShowsState> emit,
  ) {
    if (state.status != GetAllRequestStatus.loading &&
        state.status != GetAllRequestStatus.loaded &&
        !_isFetchMoreEvent(event)) {
      emit(state.copyWith(status: GetAllRequestStatus.loading));
    }
  }

  bool _isFetchMoreEvent(PopularTvShowsEvent event) =>
      event is FetchMorePopularTvShowsEvent;
}
