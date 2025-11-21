import 'package:dartz/dartz.dart';
import '../../../core/domain/usecase/base_use_case.dart';
import '../../../core/error/failure.dart';
import '../entities/search_result_item.dart';

import '../repository/search_repository.dart';

class SearchUsecase extends BaseUseCase<List<SearchResultItem>, String> {
  final SearchRepository _searchRepository;

  SearchUsecase(this._searchRepository);

  @override
  Future<Either<Failure, List<SearchResultItem>>> call(String title) async {
    return await _searchRepository.search(title);
  }
}
