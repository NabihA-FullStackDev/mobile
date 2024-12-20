import 'package:flutter/material.dart';

String convertCodeToWeatherFR(int code) {
  Map<int, String> ref = {
    0: "Ciel dégagé",
    1: "Principalement dégagé",
    2: "Partiellement nuageux",
    3: "Couvert",
    45: "Brouillard",
    48: "Brouillard givrant",
    51: "Bruine légère",
    53: "Bruine modérée",
    55: "Bruine dense",
    56: "Bruine verglaçante légère",
    57: "Bruine verglaçante dense",
    61: "Pluie légère",
    63: "Pluie modérée",
    65: "Pluie forte",
    66: "Pluie verglaçante légère",
    67: "Pluie verglaçante forte",
    71: "Neige légère",
    73: "Neige modérée",
    75: "Neige forte",
    77: "Grains de neige",
    80: "Averses de pluie légère",
    81: "Averses de pluie modérée",
    82: "Averses de pluie forte",
    85: "Averses de neige légère",
    86: "Averses de neige forte",
    95: "Orage faible/modéré",
    96: "Orage avec grêle légère",
    99: "Orage avec grêle forte",
  };
  String ret = "";
  if (ref[code] != null) ret = ref[code]!.toString();
  return (ret);
}

String convertCodeToWeatherEn(int code) {
  Map<int, String> refEn = {
    0: "Clear sky",
    1: "Mainly clear",
    2: "Partly cloudy",
    3: "Overcast",
    45: "Fog",
    48: "Rime fog",
    51: "Light drizzle",
    53: "Mod drizzle",
    55: "Dense drizzle",
    56: "Light freezing drizzle",
    57: "Dense freezing drizzle",
    61: "Slight rain",
    63: "Mod. rain",
    65: "Heavy rain",
    66: "Slight freezing rain",
    67: "Heavy freezing rain",
    71: "Slight snow",
    73: "Mod. snow",
    75: "Heavy snow",
    77: "Snow grains",
    80: "Slight rain showers",
    81: "Mod. rain showers",
    82: "Heavy rain showers",
    85: "Slight snow showers",
    86: "Heavy snow showers",
    95: "S/M Thunderstorm",
    96: "Thunderstorm with slight hail",
    99: "Thunderstorm with Heavy hail",
  };

  String ret = "";
  if (refEn[code] != null) ret = refEn[code]!.toString();
  return (ret);
}

Icon convertCodeToWeatherIcon(int code, double size) {
  switch (code) {
    case 0:
      return Icon(Icons.wb_sunny, color: Colors.orange, size: size);
    case 1:
      return Icon(Icons.wb_sunny_outlined, color: Colors.orange, size: size);

    case 2:
      return Icon(Icons.cloud_outlined, color: Colors.grey, size: size);
    case 3:
      return Icon(Icons.cloud, color: Colors.grey, size: size);

    case 45:
      return Icon(Icons.foggy, color: Colors.grey, size: size);
    case 48:
      return Icon(Icons.foggy, color: Colors.blueGrey, size: size);

    case 51:
    case 53:
    case 55:
    case 56:
    case 57:
      return Icon(Icons.grain_outlined, color: Colors.lightBlue, size: size);

    case 61:
      return Icon(Icons.shower_outlined, color: Colors.lightBlue, size: size);
    case 63:
      return Icon(Icons.shower, color: Colors.lightBlue, size: size);
    case 65:
      return Icon(Icons.shower, color: Colors.blue, size: size);
    case 66:
      return Icon(Icons.shower_outlined, color: Colors.white, size: size);
    case 67:
      return Icon(Icons.shower, color: Colors.white, size: size);
    case 80:
      return Icon(Icons.shower_outlined, color: Colors.indigo, size: size);
    case 81:
      return Icon(Icons.shower, color: Colors.indigo, size: size);
    case 82:
      return Icon(Icons.shower, color: Colors.black, size: size);

    case 71:
    case 73:
    case 75:
    case 77:
    case 85:
    case 86:
      return Icon(Icons.ac_unit, color: Colors.lightBlue, size: size);

    case 95:
    case 96:
      return Icon(Icons.flash_on_outlined, color: Colors.yellow, size: size);
    case 99:
      return Icon(Icons.flash_on, color: Colors.yellow, size: size);

    default:
      return Icon(Icons.help_outline, color: Colors.black, size: size);
  }
}
