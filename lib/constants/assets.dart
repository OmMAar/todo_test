import 'package:flutter/material.dart';

class Assets {
  Assets._();

  static const connectionError = 'assets/images/connection_err.png';
  static const unexpectedError = 'assets/images/unexpected_err.png';
  static const appLogo = 'assets/images/app_logo.png';
  static const sunBackground = 'assets/images/sun_background.png';
  static const rainBackground = 'assets/images/rain_background.png';
  static const cloudyBackground = 'assets/images/cloudy_background.png';
  static const splash_icon = 'assets/animation/splash_icon.json';
  static const loading_animated = 'assets/animation/loading_animated.json';

}

class _IconData extends IconData {
  const _IconData(int codePoint)
      : super(
    codePoint,
    fontFamily: 'WeatherIcons',
  );
}

class WeatherIcons {
  static const IconData clear_day = const _IconData(0xf00d);
  static const IconData clear_night = const _IconData(0xf02e);

  static const IconData few_clouds_day = const _IconData(0xf002);
  static const IconData few_clouds_night = const _IconData(0xf081);

  static const IconData clouds_day = const _IconData(0xf07d);
  static const IconData clouds_night = const _IconData(0xf080);

  static const IconData shower_rain_day = const _IconData(0xf009);
  static const IconData shower_rain_night = const _IconData(0xf029);

  static const IconData rain_day = const _IconData(0xf008);
  static const IconData rain_night = const _IconData(0xf028);

  static const IconData thunder_storm_day = const _IconData(0xf010);
  static const IconData thunder_storm_night = const _IconData(0xf03b);

  static const IconData snow_day = const _IconData(0xf00a);
  static const IconData snow_night = const _IconData(0xf02a);

  static const IconData mist_day = const _IconData(0xf003);
  static const IconData mist_night = const _IconData(0xf04a);
}