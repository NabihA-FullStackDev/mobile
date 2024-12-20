class TodayWeatherData {
  final List<String> times;
  final List<double> temperatures;
  final List<int> codes;
  final List<double> winds;

  TodayWeatherData({
    required this.times,
    required this.temperatures,
    required this.codes,
    required this.winds,
  });

  factory TodayWeatherData.fromTodayJson(Map<String, dynamic> json) {
    return TodayWeatherData(
      times: List<String>.from(json['time']),
      temperatures: List<double>.from(json['temperature_2m']),
      codes: List<int>.from(json['weather_code']),
      winds: List<double>.from(json['wind_speed_10m']),
    );
  }
}
