import 'package:dartz/dartz.dart';
import '../../../core/domain/entities/media.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../../core/resources/app_strings.dart';
import '../datasource/watchlist_local_data_source.dart';
import '../models/watchlist_item_model.dart';

import '../../domain/repository/watchlist_repository.dart';

class WatchlistRepositoryImpl extends WatchlistRepository {
  final WatchlistLocalDataSource _watchlistLocalDataSource;

  WatchlistRepositoryImpl(this._watchlistLocalDataSource);

  @override
  Either<Failure, List<Media>> getWatchListItems() {
    try {
      final models = _watchlistLocalDataSource.getWatchListItems();
      final entities = models
          .map((model) => model.toEntity())
          .toList()
          .reversed
          .toList();
      return Right(entities);
    } on DatabaseException {
      return Left(DatabaseFailure(AppStrings.databaseError));
    } catch (_) {
      return Left(DatabaseFailure(AppStrings.unknownError));
    }
  }

  @override
  Future<Either<Failure, int>> addWatchListItem(Media media) async {
    try {
      final model = WatchlistItemModel.fromEntity(media);
      int id = await _watchlistLocalDataSource.addWatchListItem(model);
      return Right(id);
    } on DatabaseException {
      return Left(DatabaseFailure(AppStrings.databaseError));
    } catch (_) {
      return Left(DatabaseFailure(AppStrings.unknownError));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeWatchListItem(int index) async {
    try {
      await _watchlistLocalDataSource.removeWatchListItem(index);
      return const Right(unit);
    } on DatabaseException {
      return Left(DatabaseFailure(AppStrings.databaseError));
    } catch (_) {
      return Left(DatabaseFailure(AppStrings.unknownError));
    }
  }

  @override
  Either<Failure, int> isBookmarked(int tmdbId) {
    try {
      final result = _watchlistLocalDataSource.isBookmarked(tmdbId);
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure(AppStrings.databaseError));
    } catch (_) {
      return Left(DatabaseFailure(AppStrings.unknownError));
    }
  }
}
