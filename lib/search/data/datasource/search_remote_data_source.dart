import 'package:dio/dio.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/error_message_model.dart';
import '../../domain/entities/search_result_item.dart';

import '../models/search_result_item_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchResultItem>> search(String title);
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final Dio dio;

  SearchRemoteDataSourceImpl(this.dio);

  @override
  Future<List<SearchResultItem>> search(String title) async {
    final response = await dio.get(
      ApiConstants.searchPath,
      queryParameters: {'query': title},
    );

    if (response.statusCode == 200) {
      return List<SearchResultItemModel>.from(
        (response.data['results'] as List)
            .where((e) => e['media_type'] != 'person')
            .map((i) => SearchResultItemModel.fromJson(i)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
