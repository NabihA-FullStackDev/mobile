import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'weatherApp/advanced_weather_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) {
      runApp(
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AdvancedWeatherApp(),
        ),
      );
    },
  );
}
