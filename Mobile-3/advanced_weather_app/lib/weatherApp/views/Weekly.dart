import 'package:advanced_weather_app/weatherApp/widgets/week_line_chart.dart';
import 'package:flutter/material.dart';

import '../../api/get_weekly_weather_from_location.dart';
import '../../api/tools/convert_code_weather.dart';
import '../models/page_state.dart';
import '../models/weekly_weather_data.dart';

class Weekly extends StatefulWidget {
  final dynamic infos;
  final PageState state;
  final void Function(int, PageState) updateState;

  const Weekly({
    Key? key,
    required this.infos,
    required this.state,
    required this.updateState,
  }) : super(key: key);
  @override
  State<Weekly> createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  Color backColor = const Color.fromARGB(255, 225, 129, 161).withOpacity(0.09);
  late Color _color = const Color.fromARGB(255, 0, 137, 205);
  late String _city = "";
  late String _region = "";
  late String _country = "";
  late List<String> _date = [];
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
          _color = const Color.fromARGB(255, 0, 137, 205);
          _city = infos['name'];
          _region = infos['admin1'] ?? "";
          _country = infos['country'] ?? "";
          _date = weather!.times;
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
      _date = [];
    });
  }

  void _badLocation() {
    setState(() {
      _color = Colors.black;
      _city = "Location not found";
      _region = "";
      _country = "";
      _date = [];
    });
  }

  void _apiFailure() {
    setState(() {
      _color = Colors.black;
      _city = "Request error from API";
      _region = "";
      _country = "";
      _date = [];
    });
  }

  void _serviceDenied() {
    setState(() {
      _color = Colors.black;
      _city = "Geolocation is not available,"
          " please enable it in your App settings.";
      _region = "";
      _country = "";
      _date = [];
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
        if (_date.isNotEmpty)
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
                    child: WeekLineChart(
                      date: _date,
                      tempMin: _tempMin,
                      tempMax: _tempMax,
                    ),
                  ),
                  const SizedBox(height: 42),
                  _customList(
                    _date,
                    _tempMin,
                    _tempMax,
                    _typeTemps,
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
    List<String> date,
    List<double> tempMin,
    List<double> tempMax,
    List<int> typeTemps,
  ) {
    Color backColor =
        const Color.fromARGB(255, 225, 129, 161).withOpacity(0.09);
    Color colorTmin = const Color.fromARGB(255, 0, 137, 205);
    Color colorTmax = Colors.orange;
    Color colorText = Colors.black;

    if (date.isNotEmpty) {
      return Container(
        height: 168,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: date.length,
          itemBuilder: (context, index) {
            return Container(
              width: 84,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _customText(date[index].substring(5), 24, colorText),
                  convertCodeToWeatherIcon(typeTemps[index], 27),
                  _customText("${tempMax[index]}°C", 18, colorTmax),
                  _customText("${tempMin[index]}°C", 18, colorTmin),
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
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color,
      ),
      textAlign: TextAlign.center,
    );
  }
}
