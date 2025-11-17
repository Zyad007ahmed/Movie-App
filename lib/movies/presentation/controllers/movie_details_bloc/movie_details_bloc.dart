import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/domain/entities/media_details.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/get_movie_details_usecase.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUsecase _getMovieDetailsUsecase;

  MovieDetailsBloc(this._getMovieDetailsUsecase) : super(MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
  }

  Future<void> _getMovieDetails(
    GetMovieDetailsEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final result = await _getMovieDetailsUsecase(event.id);

    result.fold(
      (l) =>
          emit(state.copyWith(status: RequestStatus.error, message: l.message)),
      (r) =>
          emit(state.copyWith(status: RequestStatus.loaded, mediaDetails: r)),
    );
  }
}
