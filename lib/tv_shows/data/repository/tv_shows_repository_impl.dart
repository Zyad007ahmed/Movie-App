import 'package:dartz/dartz.dart';
import '../../../core/domain/entities/media.dart';
import '../../../core/domain/entities/media_details.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../../core/resources/app_strings.dart';
import '../datasource/tv_shows_remote_data_source.dart';
import '../../domain/entities/season_details.dart';
import '../../domain/usecases/get_season_details_usecase.dart';

import '../../domain/repository/tv_shows_repository.dart';

class TvShowsRepositoryImpl extends TvShowsRepository {
  final TvShowsRemoteDataSource _tvShowsRemoteDataSource;

  TvShowsRepositoryImpl(this._tvShowsRemoteDataSource);

  @override
  Future<Either<Failure, List<List<Media>>>> getTvShows() async {
    try {
      final result = await _tvShowsRemoteDataSource.getTvShows();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(AppStrings.unknownError));
    }
  }

  @override
  Future<Either<Failure, MediaDetails>> getTvShowDetails(int id) async {
    try {
      final result = await _tvShowsRemoteDataSource.getTvShowDetails(id);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } catch (_) {
      return Left(ServerFailure(AppStrings.unknownError));
    }
  }

  @override
  Future<Either<Failure, SeasonDetails>> getSeasonDetails(
    SeasonDetailsParams params,
  ) async {
    try {
      final result = await _tvShowsRemoteDataSource.getTvSeasonDetails(
        params.id,
        params.seasonNumber,
      );
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } catch (_) {
      return Left(ServerFailure(AppStrings.unknownError));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getAllPopularTvShows(int page) async {
    try {
      final result = await _tvShowsRemoteDataSource.getAllPopularTvShows(page);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } catch (_) {
      return Left(ServerFailure(AppStrings.unknownError));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getAllTopRatedTvShows(int page) async {
    try {
      final result = await _tvShowsRemoteDataSource.getAllTopRatedTvShows(page);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } catch (_) {
      return Left(ServerFailure(AppStrings.unknownError));
    }
  }
}
