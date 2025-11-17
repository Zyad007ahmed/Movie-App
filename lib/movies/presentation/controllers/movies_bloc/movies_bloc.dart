import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/domain/usecase/base_use_case.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/get_movies_usecase.dart';

import '../../../../core/domain/entities/media.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesUsecase _getMoviesUsecase;

  MoviesBloc(this._getMoviesUsecase) : super(MoviesState()) {
    on<GetMoviesEvent>(_getMovies);
  }

  Future<void> _getMovies(
    GetMoviesEvent event,
    Emitter<MoviesState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final result = await _getMoviesUsecase(const NoParameters());
    
    result.fold(
      (l) =>
          emit(state.copyWith(status: RequestStatus.error, message: l.message)),
      (r) => emit(state.copyWith(status: RequestStatus.loaded, movies: r)),
    );
  }
}
