import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Datasource {
  final Dio _dio;

  Datasource({required Dio dio}) : _dio = dio;
  String apikey = dotenv.env["API_KEY"] ?? "NOT FOUND";

   Future<Map<String, dynamic>> getForeCast(
      String baseUrl, String endPoint, String country) async {
    final response = await _dio.get(
        '$baseUrl${endPoint}key=$apikey&q=$country&days=7&aqi=no&alerts=no');
    return response.data;
  }
}
