import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'weatherApp/medium_weather_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) {
      runApp(
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MediumWeatherApp(),
        ),
      );
    },
  );
}
