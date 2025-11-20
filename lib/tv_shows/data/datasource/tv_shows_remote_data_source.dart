import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/error_message_model.dart';
import '../models/season_details_model.dart';
import '../models/tv_show_details_model.dart';
import '../models/tv_show_model.dart';

abstract class TvShowsRemoteDataSource {
  Future<List<TvShowModel>> getOnAirTvShows();
  Future<List<TvShowModel>> getPopularTvShows();
  Future<List<TvShowModel>> getTopRatedTvShows();
  Future<List<List<TvShowModel>>> getTvShows();
  Future<TvShowDetailsModel> getTvShowDetails(int id);
  Future<SeasonDetailsModel> getTvSeasonDetails(int id, int seasonNumber);
  Future<List<TvShowModel>> getAllPopularTvShows(int page);
  Future<List<TvShowModel>> getAllTopRatedTvShows(int page);
}

class TvShowsRemoteDataSourceImpl extends TvShowsRemoteDataSource {
  final Dio dio;

  TvShowsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<TvShowModel>> getOnAirTvShows() async {
    final response = await dio.get(
      ApiConstants.onAirTvShowsPath,
      queryParameters: {'with_original_language': 'en'},
    );

    if (response.statusCode == 200) {
      return List<TvShowModel>.from(
        (response.data['results'] as List).map((e) => TvShowModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TvShowModel>> getPopularTvShows() async {
    final response = await dio.get(
      ApiConstants.popularTvShowsPath,
      queryParameters: {'with_original_language': 'en'},
    );

    if (response.statusCode == 200) {
      return List<TvShowModel>.from(
        (response.data['results'] as List).map((e) => TvShowModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TvShowModel>> getTopRatedTvShows() async {
    final response = await dio.get(
      ApiConstants.topRatedTvShowsPath,
      queryParameters: {'with_original_language': 'en'},
    );

    if (response.statusCode == 200) {
      return List<TvShowModel>.from(
        (response.data['results'] as List).map((e) => TvShowModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<List<TvShowModel>>> getTvShows() async {
    return await Future.wait([
      getOnAirTvShows(),
      getPopularTvShows(),
      getTopRatedTvShows(),
    ], eagerError: true);
  }

  @override
  Future<TvShowDetailsModel> getTvShowDetails(int id) async {
    final response = await dio.get(
      ApiConstants.tvShowDetailsPath(id),
      queryParameters: {'append_to_response': 'similar,videos'},
    );

    if (response.statusCode == 200) {
      return TvShowDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<SeasonDetailsModel> getTvSeasonDetails(
    int id,
    int seasonNumber,
  ) async {
    final response = await dio.get(
      ApiConstants.seasonDetailsPath(id: id, seasonNumber: seasonNumber),
    );

    if (response.statusCode == 200) {
      return SeasonDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TvShowModel>> getAllPopularTvShows(int page) async {
    final response = await dio.get(
      ApiConstants.popularTvShowsPath,
      queryParameters: {'page': page},
    );

    if (response.statusCode == 200) {
      return List<TvShowModel>.from(
        (response.data['results'] as List).map((e) => TvShowModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TvShowModel>> getAllTopRatedTvShows(int page) async {
    final response = await dio.get(
      ApiConstants.topRatedTvShowsPath,
      queryParameters: {'page': page},
    );

    if (response.statusCode == 200) {
      return List<TvShowModel>.from(
        (response.data['results'] as List).map((e) => TvShowModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
