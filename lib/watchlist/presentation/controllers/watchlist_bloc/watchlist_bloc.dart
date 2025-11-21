import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/media.dart';
import '../../../../core/domain/usecase/base_use_case.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/add_watchlist_item_use_case.dart';
import '../../../domain/usecases/get_watchlist_items_use_case.dart';
import '../../../domain/usecases/is_bookmarked_use_case.dart';
import '../../../domain/usecases/remove_watchlist_item_usecase.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc(
    this._getWatchListItemsUseCase,
    this._addWatchListItemUseCase,
    this._removeWatchListItemUseCase,
    this._isBookmarkedUseCase,
  ) : super(WatchlistState()) {
    on<GetWatchListItemsEvent>(_getWatchListItems);
    on<AddWatchListItemEvent>(_addWatchListItem);
    on<RemoveWatchListItemEvent>(_removeWatchListItem);
    on<CheckBookmarkEvent>(_checkBookmark);
  }

  final GetWatchlistItemsUseCase _getWatchListItemsUseCase;
  final AddWatchlistItemUseCase _addWatchListItemUseCase;
  final RemoveWatchlistItemUseCase _removeWatchListItemUseCase;
  final IsBookmarkedUseCase _isBookmarkedUseCase;

  Future<void> _getWatchListItems(
    GetWatchListItemsEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(const WatchlistState(status: WatchlistRequestStatus.loading));

    final result = await _getWatchListItemsUseCase.call(noParametrs);

    result.fold(
      (l) => emit(
        WatchlistState(
          status: WatchlistRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(const WatchlistState(status: WatchlistRequestStatus.empty));
        } else {
          emit(WatchlistState(status: WatchlistRequestStatus.loaded, items: r));
        }
      },
    );
  }

  Future<void> _addWatchListItem(
    AddWatchListItemEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(const WatchlistState(status: WatchlistRequestStatus.loading));

    final result = await _addWatchListItemUseCase.call(event.media);

    result.fold(
      (l) => emit(
        WatchlistState(
          status: WatchlistRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        emit(WatchlistState(actionStatus: BookmarkStatus.added, id: r));
      },
    );
  }

  Future<void> _removeWatchListItem(
    RemoveWatchListItemEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(const WatchlistState(status: WatchlistRequestStatus.loading));

    final result = await _removeWatchListItemUseCase.call(event.index);

    result.fold(
      (l) => emit(
        WatchlistState(
          status: WatchlistRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        emit(WatchlistState(actionStatus: BookmarkStatus.removed));
      },
    );
  }

  Future<void> _checkBookmark(
    CheckBookmarkEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(const WatchlistState(status: WatchlistRequestStatus.loading));

    final result = await _isBookmarkedUseCase.call(event.tmdbId);

    result.fold(
      (l) => emit(
        WatchlistState(
          status: WatchlistRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        emit(WatchlistState(actionStatus: BookmarkStatus.exists, id: r));
      },
    );
  }
}
