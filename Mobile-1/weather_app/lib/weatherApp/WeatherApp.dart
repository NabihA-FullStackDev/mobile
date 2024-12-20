import 'package:flutter/material.dart';
import 'package:weather_app/weatherApp/Today.dart';
import 'package:weather_app/weatherApp/Weekly.dart';

import 'Currently.dart';
import 'Footer.dart';
import 'Header.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentIndex = 0;
  String _location = "";
  final PageController _pageController = PageController();

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void updateText(String newLocation) {
    setState(() {
      _location = newLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchCtrler = TextEditingController();

    return Scaffold(
      appBar: Header(
        ctrl: searchCtrler,
        searched: updateText,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          Currently(
            location: _location,
          ),
          Today(
            location: _location,
          ),
          Weekly(
            location: _location,
          ),
        ],
      ),
      bottomNavigationBar: Footer(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
