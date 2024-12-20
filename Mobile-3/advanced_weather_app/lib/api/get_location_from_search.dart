import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>?> getLocationFromSearch(String search) async {
  List<dynamic>? res = [];
  final protectedSearch = Uri.encodeComponent(search);
  final url = Uri.parse('https://geocoding-api.open-meteo.com/v1/search?'
      'name=$protectedSearch'
      '&count=5&language=en&format=json');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      res = jsonDecode(response.body)['results'];
    }
  } catch (error) {
    print(error);
  }
  return (res);
}
