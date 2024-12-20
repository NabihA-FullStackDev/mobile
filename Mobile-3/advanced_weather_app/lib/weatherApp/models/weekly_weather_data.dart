class WeeklyWeatherData {
  final List<String> times;
  final List<double> tempMin;
  final List<double> tempMax;
  final List<int> codes;

  WeeklyWeatherData({
    required this.times,
    required this.tempMin,
    required this.tempMax,
    required this.codes,
  });

  factory WeeklyWeatherData.fromWeeklyJson(Map<String, dynamic> json) {
    return WeeklyWeatherData(
      times: List<String>.from(json['time']),
      tempMin: List<double>.from(json['temperature_2m_min']),
      tempMax: List<double>.from(json['temperature_2m_max']),
      codes: List<int>.from(json['weather_code']),
    );
  }
}
