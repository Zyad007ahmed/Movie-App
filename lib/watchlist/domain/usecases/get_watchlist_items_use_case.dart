import 'package:dartz/dartz.dart';
import '../../../core/domain/usecase/base_use_case.dart';
import '../../../core/error/failure.dart';

import '../../../core/domain/entities/media.dart';
import '../repository/watchlist_repository.dart';

class GetWatchlistItemsUseCase extends BaseUseCase<List<Media>, NoParameters> {
  final WatchlistRepository _watchlistRepository;

  GetWatchlistItemsUseCase(this._watchlistRepository);

  @override
  Future<Either<Failure, List<Media>>> call(NoParameters p) async {
    return _watchlistRepository.getWatchListItems();
  }
}
