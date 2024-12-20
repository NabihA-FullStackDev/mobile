import 'package:flutter/material.dart';

import '../../api/get_today_weather_from_location.dart';
import '../../api/tools/convert_code_weather.dart';
import '../models/page_state.dart';
import '../models/today_weather_data.dart';
import '../widgets/temp_line_chart.dart';

class Today extends StatefulWidget {
  final dynamic infos;
  final PageState state;
  final void Function(int, PageState) updateState;

  const Today({
    Key? key,
    required this.infos,
    required this.state,
    required this.updateState,
  }) : super(key: key);
  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  Color backColor = const Color.fromARGB(255, 225, 129, 161).withOpacity(0.09);
  late Color _color = const Color.fromARGB(255, 0, 137, 205);
  late String _city = "";
  late String _region = "";
  late String _country = "";
  late List<String> _hours = [];
  late List<double> _temperature = [];
  late List<int> _typeTemps = [];
  late List<double> _windSpeed = [];

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
  void didUpdateWidget(covariant Today oldWidget) {
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
        final TodayWeatherData? weather = await getTodayWeatherFromLocation(
          infos['latitude'].toString(),
          infos['longitude'].toString(),
        );
        setState(() {
          _color = const Color.fromARGB(255, 0, 137, 205);
          _city = infos['name'];
          _region = infos['admin1'] ?? "";
          _country = infos['country'] ?? "";
          _hours = weather!.times;
          _temperature = weather.temperatures;
          _typeTemps = weather.codes;
          _windSpeed = weather.winds;
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
      _color = Colors.black;
      _city = "Location not found";
      _region = "";
      _country = "";
      _hours = [];
    });
  }

  void _apiFailure() {
    setState(() {
      _color = Colors.black;
      _city = "Request error from API";
      _region = "";
      _country = "";
      _hours = [];
    });
  }

  void _serviceDenied() {
    setState(() {
      _color = Colors.black;
      _city = "Geolocation is not available,"
          " please enable it in your App settings.";
      _region = "";
      _country = "";
      _hours = [];
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
        if (_hours.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 42),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: backColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: TempLineChart(
                        hours: _hours, temperatures: _temperature),
                  ),
                  const SizedBox(height: 42),
                  _customList(
                    _hours,
                    _temperature,
                    _typeTemps,
                    _windSpeed,
                  ),
                  const SizedBox(height: 84),
                ],
              ),
            ),
          ),
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

  Widget _customList(
    List<String> hours,
    List<double> temperature,
    List<int> typeTemps,
    List<double> windSpeed,
  ) {
    Color backColor =
        const Color.fromARGB(255, 225, 129, 161).withOpacity(0.09);
    Color colorT = const Color.fromARGB(255, 0, 137, 205);
    Color colorText = Colors.black;

    if (hours.isNotEmpty) {
      return Container(
        height: 168,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: hours.length,
          itemBuilder: (context, index) {
            return Container(
              width: 84,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _customText(hours[index].split('T')[1], 21, colorText),
                  _customText("${temperature[index]}°C", 21, colorT),
                  convertCodeToWeatherIcon(typeTemps[index], 21),
                  _customText("${windSpeed[index]} Km/h", 14, colorText),
                ],
              ),
            );
          },
        ),
      );
    }
    return const Text("");
  }

  Widget _customText(String text, double size, Color color) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color),
      textAlign: TextAlign.center,
    );
  }
}
