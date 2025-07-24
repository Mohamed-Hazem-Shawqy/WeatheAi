class WeatherModel {
  final double maxTemp;
  final double minTemp;
  final double avgTemp;
  final String text;
  final String icon;
  final String date;
  final int humidity;
  final int chanceOfRain;

  WeatherModel({
    required this.maxTemp,
    required this.minTemp,
    required this.avgTemp,
    required this.text,
    required this.icon,
    required this.date,
    required this.humidity,
    required this.chanceOfRain,
  });
  factory WeatherModel.fromjson(Map<String, dynamic> json, int index) {
    return WeatherModel(
      maxTemp:
          json["forecast"]['forecastday'][index]['day']['maxtemp_c'] ?? 0.0,
      minTemp:
          json["forecast"]['forecastday'][index]['day']['mintemp_c'] ?? 0.0,
      avgTemp:
          json["forecast"]['forecastday'][index]['day']['avgtemp_c'] ?? 0.0,
      text: json["forecast"]['forecastday'][index]['day']['condition']
              ['text'] ??
          '',
      icon: json["forecast"]['forecastday'][index]['day']['condition']
              ['icon'] ??
          '',
      date: json["forecast"]['forecastday'][index]['date'],
      humidity: json['current']['humidity'],
      chanceOfRain: json["forecast"]['forecastday'][index]['day']['daily_chance_of_rain']
    );
  }
}
