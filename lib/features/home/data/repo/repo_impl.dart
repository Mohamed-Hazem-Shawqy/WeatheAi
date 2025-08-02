import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_ai/core/Api/api_error_handeler.dart';
import 'package:weather_ai/features/home/data/data_source/data_source.dart';
import 'package:weather_ai/features/home/data/model/model.dart';

import 'package:weather_ai/features/home/domian/repo/repo_decl.dart';

import 'package:weather_ai/features/home/data/repo/repo_decl.dart';


class RepoImpl implements RepoDecl {
  final Datasource datasource;

  RepoImpl({required this.datasource});
  @override
  Future<Either<ServerFailure, List<WeatherModel>>> getForeCast(
      String baseUrl, String endPoint, String country) async {
    try {
      final response = await datasource.getForeCast(baseUrl, endPoint, country);

      List<WeatherModel> addForecast = [];

      for (int i = 0; i < response["forecast"]["forecastday"].length; i++) {
        final res = WeatherModel.fromjson(response, i);
        addForecast.add(res);
      }
      return right(addForecast);
    } on DioException catch (e) {
      return left(
        ServerFailure.fromdioException(e),
      );
    } catch (e) {

      print(e);


      return left(
        ServerFailure(
          errIcon: Icons.error,
          statusCode: 500,
          errMessage: 'Unexpected error occurred.',
        ),
      );
    }
  }
}
