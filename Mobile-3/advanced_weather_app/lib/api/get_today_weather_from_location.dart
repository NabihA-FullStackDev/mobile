import 'dart:convert';
import 'package:http/http.dart' as http;

import '../weatherApp/models/today_weather_data.dart';

Future<TodayWeatherData?> getTodayWeatherFromLocation(
    String latitude, String longitude) async {
  final protectedLat = Uri.encodeComponent(latitude.toString());
  final protectedlon = Uri.encodeComponent(longitude.toString());
  final url = Uri.parse("https://api.open-meteo.com/v1/forecast?"
      "latitude=$protectedLat"
      "&longitude=$protectedlon"
      "&hourly=temperature_2m,weather_code,wind_speed_10m&forecast_days=1");

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return TodayWeatherData.fromTodayJson(
          jsonDecode(response.body)['hourly']);
    }
  } catch (error) {
    print(error);
  }
  return null;
}
