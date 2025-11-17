import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/get_all_top_rated_movies_usecase.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../../core/utils/enums.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetAllTopRatedMoviesUsecase _getAllTopRatedMoviesUsecase;

  TopRatedMoviesBloc(this._getAllTopRatedMoviesUsecase) : super(TopRatedMoviesState()) {
    on<GetTopRatedMoviesEvent>(_getAllTopRatedMovies);
    on<FetchMoreTopRatedMoviesEvent>(_fetchMoreMovies);
  }
  
  int page = 1;

  Future<void> _getAllTopRatedMovies(
    GetTopRatedMoviesEvent event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    if (state.status != GetAllRequestStatus.loading &&
        state.status != GetAllRequestStatus.loaded) {
      emit(state.copyWith(status: GetAllRequestStatus.loading));
    }
    await _getMovies(emit);
  }

  Future<void> _getMovies(
    Emitter<TopRatedMoviesState> emit, {
    bool isFetchMoreMovies = false,
  }) async {
    final result = await _getAllTopRatedMoviesUsecase(page);

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
    FetchMoreTopRatedMoviesEvent event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    await _getMovies(emit, isFetchMoreMovies: true);
  }
}
