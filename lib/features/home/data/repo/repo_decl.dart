import 'package:dartz/dartz.dart';
import 'package:weather_ai/core/Api/api_error_handeler.dart';
import 'package:weather_ai/features/home/data/model/model.dart';

abstract class RepoDecl {
  Future<Either<ServerFailure, List<WeatherModel>>> getForeCast(
      String baseUrl, String endPoint, String country);
}
