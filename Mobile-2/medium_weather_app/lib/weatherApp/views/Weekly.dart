import 'package:flutter/material.dart';
import 'package:medium_weather_app/api/tools/convert_code_weather.dart';
import 'package:medium_weather_app/weatherApp/models/page_state.dart';

import '../../api/get_weekly_weather_from_location.dart';
import '../models/weekly_weather_data.dart';

class Weekly extends StatefulWidget {
  final dynamic infos;
  final PageState state;
  final void Function(int, PageState) updateState;

  const Weekly({
    super.key,
    required this.infos,
    required this.state,
    required this.updateState,
  });
  @override
  State<Weekly> createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  late String _city = "";
  late String _region = "";
  late String _country = "";
  late List<String> _hours = [];
  late List<double> _tempMax = [];
  late List<double> _tempMin = [];
  late List<int> _typeTemps = [];

  @override
  void initState() {
    super.initState();
    switch (widget.state) {
      case PageState.success:
        _getWeather(widget.infos);
        break;
      case PageState.badLocation:
        _badLocation();
        break;
      case PageState.apiFailure:
        _apiFailure();
        break;
      case PageState.serviceDenied:
        _serviceDenied();
        break;
      case PageState.idle:
        break;
      default:
        _cleanPage();
    }
  }

  @override
  void didUpdateWidget(covariant Weekly oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      switch (widget.state) {
        case PageState.success:
          _getWeather(widget.infos);
          break;
        case PageState.badLocation:
          _badLocation();
          break;
        case PageState.apiFailure:
          _apiFailure();
          break;
        case PageState.serviceDenied:
          _serviceDenied();
          break;
        case PageState.idle:
          break;
        default:
          _cleanPage();
      }
    }
  }

  void _getWeather(dynamic infos) async {
    if (infos != null) {
      try {
        final WeeklyWeatherData? weather = await getWeeklyWeatherFromLocation(
          infos['latitude'].toString(),
          infos['longitude'].toString(),
        );
        setState(() {
          _city = infos['name'];
          _region = infos['admin1'] ?? "";
          _country = infos['country'] ?? "";
          _hours = weather!.times;
          _tempMin = weather.tempMin;
          _tempMax = weather.tempMax;
          _typeTemps = weather.codes;
        });
      } catch (e) {
        widget.updateState(1, PageState.apiFailure);
      }
    }
  }

  void _cleanPage() {
    setState(() {
      _city = "";
      _region = "";
      _country = "";
      _hours = [];
    });
  }

  void _badLocation() {
    setState(() {
      _city = "Location not found";
      _region = "";
      _country = "";
      _hours = [];
    });
  }

  void _apiFailure() {
    setState(() {
      _city = "Request error from API";
      _region = "";
      _country = "";
      _hours = [];
    });
  }

  void _serviceDenied() {
    setState(() {
      _city = "Geolocation is not available,";
      _region = "please enable it in your App settings.";
      _country = "";
      _hours = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _customText(_city),
          _customText(_region),
          _customText(_country),
          _customList(
            _hours,
            _tempMin,
            _tempMax,
            _typeTemps,
          ),
        ],
      ),
    );
  }

  Widget _customList(
    List<String> hours,
    List<double> tempMin,
    List<double> tempMax,
    List<int> typeTemps,
  ) {
    if (hours.isNotEmpty) {
      return Expanded(
        child: ListView.builder(
          itemCount: hours.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(hours[index]),
                    Text("/ ${tempMin[index]} °C"),
                    Text("/ ${tempMax[index]} °C"),
                    Text("/ ${convertCodeToWeather(typeTemps[index])}"),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
    return const Text("");
  }

  Widget _customText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 24),
      textAlign: TextAlign.center,
    );
  }
}
