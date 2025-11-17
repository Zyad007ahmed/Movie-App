import 'package:dartz/dartz.dart';
import '../../../core/domain/entities/media.dart';
import '../../../core/domain/usecase/base_use_case.dart';
import '../../../core/error/failure.dart';

import '../repository/movies_repository.dart';

class GetAllPopularMoviesUsecase extends BaseUseCase<List<Media>, int> {
  final MoviesRepository _moviesRepository;

  GetAllPopularMoviesUsecase(this._moviesRepository);
  @override
  Future<Either<Failure, List<Media>>> call(int page) async {
    return await _moviesRepository.getAllPopularMovies(page);
  }
}
