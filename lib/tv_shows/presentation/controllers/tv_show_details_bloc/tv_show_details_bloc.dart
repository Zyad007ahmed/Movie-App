import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/domain/entities/media_details.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/entities/season_details.dart';
import '../../../domain/usecases/get_season_details_usecase.dart';
import '../../../domain/usecases/get_tv_shows_details_usecase.dart';

part 'tv_show_details_event.dart';
part 'tv_show_details_state.dart';

class TvShowDetailsBloc extends Bloc<TvShowDetailsEvent, TvShowDetailsState> {
  TvShowDetailsBloc(
    this._getTvShowDetailsUsecase,
    this._getSeasonDetailsUsecase,
  ) : super(TvShowDetailsState()) {
    on<GetTvShowDetailsEvent>(_getTvShowDetails);
    on<GetSeasonDetailsEvent>(_getSeasonDetails);
  }

  final GetTvShowDetailsUsecase _getTvShowDetailsUsecase;
  final GetSeasonDetailsUsecase _getSeasonDetailsUsecase;

  Future<void> _getTvShowDetails(
    GetTvShowDetailsEvent event,
    Emitter<TvShowDetailsState> emit,
  ) async {
    emit(state.copyWith(tvShowDetailsStatus: RequestStatus.loading));

    final result = await _getTvShowDetailsUsecase(event.id);

    result.fold(
      (l) => emit(
        state.copyWith(
          tvShowDetailsStatus: RequestStatus.error,
          tvShowDetailsMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          tvShowDetailsStatus: RequestStatus.loaded,
          tvShowDetails: r,
        ),
      ),
    );
  }

  Future<void> _getSeasonDetails(
    GetSeasonDetailsEvent event,
    Emitter<TvShowDetailsState> emit,
  ) async {
    emit(state.copyWith(seasonDetailsStatus: RequestStatus.loading));

    final result = await _getSeasonDetailsUsecase(
      SeasonDetailsParams(id: event.id, seasonNumber: event.seasonNumber),
    );

    result.fold(
      (l) => emit(
        state.copyWith(
          seasonDetailsStatus: RequestStatus.error,
          seasonDetailsMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          seasonDetailsStatus: RequestStatus.loaded,
          seasonDetails: r,
        ),
      ),
    );
  }
}
