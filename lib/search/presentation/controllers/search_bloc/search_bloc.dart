import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/search_result_item.dart';
import '../../../domain/usecases/search_usecase.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._searchUsecase) : super(SearchState()) {
    on<GetSearchResultsEvent>(_search, transformer: debounce(_duration));
  }

  static const _duration = Duration(milliseconds: 400);

  EventTransformer<Event> debounce<Event>(Duration duration) {
    return (events, mapper) => events.debounce(duration).switchMap(mapper);
  }

  final SearchUsecase _searchUsecase;

  Future<void> _search(
    GetSearchResultsEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.title.trim().isEmpty) {
      return emit(state.copyWith(status: SearchRequestStatus.empty));
    }

    emit(state.copyWith(status: SearchRequestStatus.loading));

    final result = await _searchUsecase(event.title);

    result.fold(
      (l) => emit(
        state.copyWith(status: SearchRequestStatus.error, message: l.message),
      ),
      (r) {
        if (r.isEmpty) {
          emit(state.copyWith(status: SearchRequestStatus.empty));
        } else {
          emit(
            state.copyWith(
              status: SearchRequestStatus.loaded,
              searchResults: r,
            ),
          );
        }
      },
    );
  }
}
