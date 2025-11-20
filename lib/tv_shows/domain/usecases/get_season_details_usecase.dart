import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/domain/usecase/base_use_case.dart';
import '../../../core/error/failure.dart';
import '../repository/tv_shows_repository.dart';

import '../entities/season_details.dart';

class GetSeasonDetailsUsecase
    extends BaseUseCase<SeasonDetails, SeasonDetailsParams> {
  final TvShowsRepository _tvShowsRepository;

  GetSeasonDetailsUsecase(this._tvShowsRepository);

  @override
  Future<Either<Failure, SeasonDetails>> call(
    SeasonDetailsParams params,
  ) async {
    return await _tvShowsRepository.getSeasonDetails(params);
  }
}

class SeasonDetailsParams extends Equatable {
  final int id;
  final int seasonNumber;

  const SeasonDetailsParams({required this.id, required this.seasonNumber});

  @override
  List<Object?> get props => [id, seasonNumber];
}
