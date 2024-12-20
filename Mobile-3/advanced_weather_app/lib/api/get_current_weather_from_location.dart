import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> getCurrentWeatherFromLocation(
    String latitude, String longitude) async {
  final protectedLat = Uri.encodeComponent(latitude.toString());
  final protectedlon = Uri.encodeComponent(longitude.toString());
  final url = Uri.parse("https://api.open-meteo.com/v1/forecast?"
      "latitude=$protectedLat"
      "&longitude=$protectedlon"
      "&current=temperature_2m,weather_code,wind_speed_10m");
  List<String> res = [];

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final tmp = jsonDecode(response.body)['current'];
      res.add(tmp['temperature_2m'].toString());
      res.add("${tmp['weather_code']}");
      res.add(tmp['wind_speed_10m'].toString());
    }
  } catch (error) {
    print(error);
  }
  return res;
}
