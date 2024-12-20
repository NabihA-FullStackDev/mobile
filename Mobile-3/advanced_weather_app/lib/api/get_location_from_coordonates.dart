import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> getLocationFromCoordonates(double lat, double lon) async {
  dynamic ret;
  final protectLat = Uri.encodeComponent(lat.toString());
  final protectLon = Uri.encodeComponent(lon.toString());
  final url =
      Uri.parse("https://nominatim.openstreetmap.org/reverse?format=json&"
          "lat=$protectLat"
          "&lon=$protectLon"
          "&zoom=18&addressdetails=18");
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body)['address'];
      if (res != null) {
        ret = {
          "name": res['city'] ?? "Name not found",
          "admin1": res['county'] ?? "",
          "country": res['country'] ?? "",
          "latitude": lat,
          "longitude": lon,
        };
        return (ret);
      }
    }
  } catch (error) {
    print(error);
  }
  return (null);
}
