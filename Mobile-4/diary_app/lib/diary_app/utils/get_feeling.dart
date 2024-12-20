import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData? getFeeling(String feel) {
  switch (feel) {
    case "hoppy":
      return (FontAwesomeIcons.faceSmile);
    case "angry":
      return (FontAwesomeIcons.faceAngry);
    case "neutral":
      return (FontAwesomeIcons.faceMeh);
    case "sad":
      return (FontAwesomeIcons.faceSadTear);
    default:
      return (null);
  }
}
