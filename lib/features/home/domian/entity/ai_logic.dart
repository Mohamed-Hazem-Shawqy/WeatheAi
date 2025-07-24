import 'package:dio/dio.dart';
import 'package:weather_ai/features/home/data/model/model.dart';

class AiLogic {
  final List<WeatherModel> weatherModel;
  final Dio dio;

  AiLogic({required this.dio, required this.weatherModel});

  Future<List<int>> preparListToModel(int index) async {
    List<int> weather = [];
    if (weatherModel[index].chanceOfRain > 50 &&
        weatherModel[index].avgTemp > 20 &&
        weatherModel[index].maxTemp > 38 &&
        weatherModel[index].minTemp > 17 &&
        weatherModel[index].humidity > 50) {
      weather.addAll([1, 1, 1, 0, 1]);
      return weather;
    } else {
      weather.addAll([0, 0, 0, 1, 0]);
      return weather;
    }
  }

  Future<int?> predict(int index) async {
    final feature = await preparListToModel(index);

    try {
      final response = await dio.post(
        'http://10.0.2.2:5001/predict',
        data: {'features': feature},
      );

      if (response.statusCode == 200) {
        print('${response.data['prediction'][0]}');
        return response.data['prediction'][0];
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }
}
