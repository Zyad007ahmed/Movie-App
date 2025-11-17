import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/get_all_popular_movies_usecase.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetAllPopularMoviesUsecase _getAllPopularMoviesUsecase;

  PopularMoviesBloc(this._getAllPopularMoviesUsecase)
    : super(PopularMoviesState()) {
    on<GetPopularMoviesEvent>(_getAllPopularMovies);
    on<FetchMorePopularMoviesEvent>(_fetchMoreMovies);
  }

  int page = 1;

  Future<void> _getAllPopularMovies(
    GetPopularMoviesEvent event,
    Emitter<PopularMoviesState> emit,
  ) async {
    if (state.status != GetAllRequestStatus.loading &&
        state.status != GetAllRequestStatus.loaded) {
      emit(state.copyWith(status: GetAllRequestStatus.loading));
    }
    await _getMovies(emit);
  }

  Future<void> _getMovies(
    Emitter<PopularMoviesState> emit, {
    bool isFetchMoreMovies = false,
  }) async {
    final result = await _getAllPopularMoviesUsecase(page);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: isFetchMoreMovies
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
            movies: state.movies + r,
          ),
        );
      },
    );
  }

  Future<void> _fetchMoreMovies(
    FetchMorePopularMoviesEvent event,
    Emitter<PopularMoviesState> emit,
  ) async {
    await _getMovies(emit, isFetchMoreMovies: true);
  }
}
