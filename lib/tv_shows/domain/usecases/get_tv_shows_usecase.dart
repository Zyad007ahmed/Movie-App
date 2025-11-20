import 'package:dartz/dartz.dart';
import '../../../core/domain/usecase/base_use_case.dart';
import '../../../core/error/failure.dart';
import '../repository/tv_shows_repository.dart';

import '../../../core/domain/entities/media.dart';

class GetTvShowsUsecase extends BaseUseCase<List<List<Media>>, NoParameters> {
  final TvShowsRepository _tvShowsRepository;

  GetTvShowsUsecase(this._tvShowsRepository);

  @override
  Future<Either<Failure, List<List<Media>>>> call(NoParameters p) async {
    return await _tvShowsRepository.getTvShows();
  }
}
