import 'dart:async';
import 'dart:convert';

import 'package:morphosis_flutter_demo/models/weather/weather_forecast_list_response.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.auth_token);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }


  // save response for one in day
  Future<bool> saveWeather(WeatherForecastListResponse response) async {
    return _sharedPreference.setString(Preferences.weatherResponse, jsonEncode(response.toJson()));
  }

  Future<WeatherForecastListResponse?> getWeather() async {
    try {
      String jsonData = _sharedPreference.getString(Preferences.weatherResponse)!;
      if (jsonData != null) {
        return WeatherForecastListResponse.fromJson(jsonDecode(jsonData));
      } else {
        return null;
      }
    } catch (exc, stackTrace) {
      return null;
    }
  }

  Future<DateTime?> get currentFetchingTime async {
    try {
      String jsonData = _sharedPreference.getString(Preferences.fetchInfoTime)!;
      if (jsonData != null) {
        DateTime tempDate =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse(jsonData);
        return tempDate;
      } else {
        return null;
      }
    } catch (exc, stackTrace) {
      return null;
    }
  }

  Future<void> saveFetchingTime() async {
    String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    _sharedPreference.setString(Preferences.fetchInfoTime, date);
  }
}