import 'dart:convert';
import 'package:http/http.dart' as http;

import '../weatherApp/models/weekly_weather_data.dart';

Future<WeeklyWeatherData?> getWeeklyWeatherFromLocation(
    String latitude, String longitude) async {
  final protectedLat = Uri.encodeComponent(latitude.toString());
  final protectedlon = Uri.encodeComponent(longitude.toString());
  final url = Uri.parse("https://api.open-meteo.com/v1/forecast?"
      "latitude=$protectedLat"
      "&longitude=$protectedlon"
      "&daily=weather_code,temperature_2m_max,temperature_2m_min");

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return WeeklyWeatherData.fromWeeklyJson(
          jsonDecode(response.body)['daily']);
    }
  } catch (error) {
    print(error);
  }
  return (null);
}
