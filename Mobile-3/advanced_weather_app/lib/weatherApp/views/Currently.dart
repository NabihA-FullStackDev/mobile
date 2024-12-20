import 'package:advanced_weather_app/api/tools/convert_code_weather.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../api/get_current_weather_from_location.dart';
import '../models/page_state.dart';

class Currently extends StatefulWidget {
  final dynamic infos;
  final PageState state;
  final void Function(int, PageState) updateState;

  const Currently({
    Key? key,
    required this.infos,
    required this.state,
    required this.updateState,
  }) : super(key: key);
  @override
  State<Currently> createState() => _CurrentlyState();
}

class _CurrentlyState extends State<Currently> {
  Color backColor = const Color.fromARGB(255, 225, 129, 161).withOpacity(0.09);
  late Color _color = const Color.fromARGB(255, 0, 137, 205);
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
          _color = const Color.fromARGB(255, 0, 137, 205);
          _city = infos['name'];
          _region = infos['admin1'] ?? "";
          _country = infos['country'] ?? "";
          _temperature = weather[0];
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
      _color = Colors.black;
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
      _color = Colors.black;
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
      _color = Colors.black;
      _city =
          "Geolocation is not available, please enable it in your App settings.";
      _region = "";
      _country = "";
      _temperature = "";
      _typeTemps = "";
      _windSpeed = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        _customTitle(_city, _color),
        _customSubTitle(_region, _country),
        const SizedBox(height: 84),
        if (_temperature != "" && _typeTemps != "" && _windSpeed != "")
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 42),
                decoration: BoxDecoration(
                  color: backColor,
                  borderRadius: BorderRadius.circular(65.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _customTemperature(_temperature),
                    const SizedBox(height: 42),
                    _customTypeTemp(_typeTemps),
                    const SizedBox(height: 84),
                    _customWind(_windSpeed),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _customTitle(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 42,
        color: color,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _customSubTitle(String sub1, String sub2) {
    const double fontSize = 20.0;
    const Color color = Color.fromARGB(255, 0, 137, 205);

    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: (sub1 != "") ? sub1 : "",
            style: const TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.w300,
            ),
          ),
          TextSpan(
            text: (sub2 != "" && sub1 != "")
                ? ", $sub2"
                : (sub2 != "")
                    ? sub2
                    : "",
            style: const TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _customTemperature(String text) {
    Color color = const Color.fromARGB(255, 0, 137, 205);

    return Text(
      "$text°C",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 48,
        color: color,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _customTypeTemp(String text) {
    int code = int.parse(text);
    Color color = const Color.fromARGB(255, 0, 137, 205);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          convertCodeToWeatherEn(code),
          style: TextStyle(
            fontSize: 24,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        convertCodeToWeatherIcon(code, 84),
      ],
    );
  }

  Widget _customWind(String text) {
    Color color = const Color.fromARGB(255, 0, 137, 205);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          FontAwesomeIcons.wind,
          color: color,
          size: 24,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
