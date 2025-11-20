import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/domain/usecase/base_use_case.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/get_tv_shows_usecase.dart';

import '../../../../core/domain/entities/media.dart';

part 'tv_shows_event.dart';
part 'tv_shows_state.dart';

class TvShowsBloc extends Bloc<GetTvShowsEvent, TvShowsState> {
  TvShowsBloc(this._getTvShowsUsecase) : super(TvShowsState()) {
    on<GetTvShowsEvent>(_getTvShows);
  }

  final GetTvShowsUsecase _getTvShowsUsecase;

  Future<void> _getTvShows(
    GetTvShowsEvent event,
    Emitter<TvShowsState> emit,
  ) async {
    emit(TvShowsState(status: RequestStatus.loading));

    final result = await _getTvShowsUsecase(noParametrs);

    result.fold(
      (l) => emit(const TvShowsState(status: RequestStatus.error)),
      (r) => emit(TvShowsState(status: RequestStatus.loaded, tvShows: r)),
    );
  }
}
