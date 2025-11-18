import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/entities/media.dart';

import '../../../core/error/failure.dart';

abstract class WatchlistRepository {
  Either<Failure, List<Media>> getWatchListItems();
  Future<Either<Failure, int>> addWatchListItem(Media media);
  Future<Either<Failure, Unit>> removeWatchListItem(int index);
  Either<Failure, int> isBookmarked(int tmdbId);
}
