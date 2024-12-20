String convertCodeToWeather(int code) {
  Map<int, String> ref = {
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
  if (ref[code] != null) ret = ref[code]!.toString();
  return (ret);
}
