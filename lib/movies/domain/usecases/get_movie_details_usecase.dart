import 'package:dartz/dartz.dart';

import '../../../core/domain/entities/media_details.dart';
import '../../../core/domain/usecase/base_use_case.dart';
import '../../../core/error/failure.dart';
import '../repository/movies_repository.dart';

class GetMovieDetailsUsecase extends BaseUseCase<MediaDetails, int> {
  final MoviesRepository _moviesRepository;

  GetMovieDetailsUsecase(this._moviesRepository);

  @override
  Future<Either<Failure, MediaDetails>> call(int movieId) async {
    return await _moviesRepository.getMovieDetails(movieId);
  }
}
