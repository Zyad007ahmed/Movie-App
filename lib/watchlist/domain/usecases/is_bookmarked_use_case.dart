import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/usecase/base_use_case.dart';
import 'package:movie_app/core/error/failure.dart';

import '../repository/watchlist_repository.dart';


class IsBookmarkedUseCase extends BaseUseCase<int,int>{
  final WatchlistRepository _watchlistRepository;

  IsBookmarkedUseCase(this._watchlistRepository);

  @override
  Future<Either<Failure, int>> call(int tmdbId) async{
    return _watchlistRepository.isBookmarked(tmdbId);
  }
  
  }