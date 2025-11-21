import 'package:dartz/dartz.dart';

import '../../../core/domain/entities/media.dart';
import '../../../core/domain/usecase/base_use_case.dart';
import '../../../core/error/failure.dart';
import '../repository/tv_shows_repository.dart';

class GetAllTopRatedTvShowsUsecase extends BaseUseCase<List<Media>, int> {
  final TvShowsRepository _tvShowsRepository;

  GetAllTopRatedTvShowsUsecase(this._tvShowsRepository);

  @override
  Future<Either<Failure, List<Media>>> call(int page) async {
    return await _tvShowsRepository.getAllTopRatedTvShows(page);
  }
}
