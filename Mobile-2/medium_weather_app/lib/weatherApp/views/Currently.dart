import 'package:flutter/material.dart';
import 'package:medium_weather_app/api/get_current_weather_from_location.dart';
import 'package:medium_weather_app/weatherApp/models/page_state.dart';

class Currently extends StatefulWidget {
  final dynamic infos;
  final PageState state;
  final void Function(int, PageState) updateState;

  const Currently({
    super.key,
    required this.infos,
    required this.state,
    required this.updateState,
  });
  @override
  State<Currently> createState() => _CurrentlyState();
}

class _CurrentlyState extends State<Currently> {
  late String _city = "";
  late String _region = "";
  late String _country = "";
  late String _temperature = "";
  late String _typeTemps = "";
  late String _windSpeed = "";

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
  void didUpdateWidget(covariant Currently oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      switch (widget.state) {
        case PageState.idle:
          break;
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
        default:
          _cleanPage();
      }
    }
  }

  void _getWeather(dynamic infos) async {
    if (infos != null) {
      try {
        final weather = await getCurrentWeatherFromLocation(
          infos['latitude'].toString(),
          infos['longitude'].toString(),
        );
        setState(() {
          _city = infos['name'];
          _region = infos['admin1'] ?? "";
          _country = infos['country'] ?? "";
          _temperature = "${weather[0]}°C";
          _typeTemps = weather[1];
          _windSpeed = "${weather[2]} km/h";
        });
      } catch (e) {
        widget.updateState(0, PageState.apiFailure);
      }
    }
  }

  void _cleanPage() {
    setState(() {
      _city = "";
      _region = "";
      _country = "";
      _temperature = "";
      _typeTemps = "";
      _windSpeed = "";
    });
  }

  void _badLocation() {
    setState(() {
      _city = "Location not found";
      _region = "";
      _country = "";
      _temperature = "";
      _typeTemps = "";
      _windSpeed = "";
    });
  }

  void _apiFailure() {
    setState(() {
      _city = "Request error from API";
      _region = "";
      _country = "";
      _temperature = "";
      _typeTemps = "";
      _windSpeed = "";
    });
  }

  void _serviceDenied() {
    setState(() {
      _city = "Geolocation is not available,";
      _region = "please enable it in your App settings.";
      _country = "";
      _temperature = "";
      _typeTemps = "";
      _windSpeed = "";
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
          _customText(_temperature),
          _customText(_typeTemps),
          _customText(_windSpeed),
        ],
      ),
    );
  }

  Widget _customText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 24),
      textAlign: TextAlign.center,
    );
  }
}
