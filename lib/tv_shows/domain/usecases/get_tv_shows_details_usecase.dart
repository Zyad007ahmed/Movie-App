import 'package:dartz/dartz.dart';
import '../../../core/domain/entities/media_details.dart';
import '../../../core/domain/usecase/base_use_case.dart';
import '../../../core/error/failure.dart';
import '../repository/tv_shows_repository.dart';

class GetTvShowDetailsUsecase extends BaseUseCase<MediaDetails, int> {
  final TvShowsRepository _tvShowsRepository;

  GetTvShowDetailsUsecase(this._tvShowsRepository);

  @override
  Future<Either<Failure, MediaDetails>> call(int id) async {
    return await _tvShowsRepository.getTvShowDetails(id);
  }
}
