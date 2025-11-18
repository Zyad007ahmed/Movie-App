import 'package:hive/hive.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/watchlist/data/models/watchlist_item_model.dart';

abstract class WatchlistLocalDataSource {
  List<WatchlistItemModel> getWatchListItems();
  Future<int> addWatchListItem(WatchlistItemModel item);
  Future<void> removeWatchListItem(int index);
  int isBookmarked(int tmdbId);
}

class WatchlistLocalDataSourceImpl extends WatchlistLocalDataSource {
  final Box<WatchlistItemModel> _box;

  WatchlistLocalDataSourceImpl(this._box);

  @override
  List<WatchlistItemModel> getWatchListItems() {
    try {
      return _box.values.toList();
    } catch (e) {
      throw DatabaseException(errorMessage: e.toString());
    }
  }

  @override
  Future<int> addWatchListItem(WatchlistItemModel item) async {
    try {
      return await _box.add(item);
    } catch (e) {
      throw DatabaseException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> removeWatchListItem(int index) async {
    try {
      return await _box.deleteAt(index);
    } catch (e) {
      throw DatabaseException(errorMessage: e.toString());
    }
  }

  @override
  int isBookmarked(int tmdbId) {
    try {
      final models = _box.values.toList();
      return models.indexWhere((model) => model.tmdbId == tmdbId);
    } catch (e) {
      throw DatabaseException(errorMessage: e.toString());
    }
  }
}
