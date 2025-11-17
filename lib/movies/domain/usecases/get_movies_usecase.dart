import 'package:dartz/dartz.dart';
import '../../../core/domain/usecase/base_use_case.dart';
import '../../../core/error/failure.dart';
import '../repository/movies_repository.dart';

import '../../../core/domain/entities/media.dart';

class GetMoviesUsecase extends BaseUseCase<List<List<Media>>, NoParameters> {
  final MoviesRepository _moviesRepository;

  GetMoviesUsecase(this._moviesRepository);

  @override
  Future<Either<Failure, List<List<Media>>>> call(NoParameters p) async {
    return await _moviesRepository.getMovies();
  }
}
