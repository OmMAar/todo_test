import 'dart:async';

import 'package:morphosis_flutter_demo/constants/app_config.dart';
import 'package:morphosis_flutter_demo/data/sharedpref/shared_preference_helper.dart';
import 'package:morphosis_flutter_demo/models/weather/weather_forecast_list_response.dart';

import 'local/datasources/weather/weather_datasource.dart';
import 'network/weather/weather_api.dart';

class Repository {
  // data source object
  final WeatherDataSource _weatherDataSource;

  // api objects
  final WeatherApi _weatherApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._weatherApi, this._sharedPrefsHelper, this._weatherDataSource);

  // weather: ---------------------------------------------------------------------

  Future<WeatherForecastListResponse> getWeatherInfo(
      {required Map<String, dynamic> params}) async {
    var _weatherInfo;

    var lastFetchedDataTime = await _sharedPrefsHelper.currentFetchingTime;

    /// is not first time
    if (lastFetchedDataTime != null) {
      DateTime dateTime = DateTime.now();
      if (AppConfigs.isEqualDate(dateTime, lastFetchedDataTime)) {
        final _data = await _sharedPrefsHelper.getWeather();

        if (_data != null) {
          return _data;
        } else {
          _weatherInfo = await _weatherApi.getWeatherInfo(params: params);
          await _sharedPrefsHelper.saveWeather(_weatherInfo);
          await _sharedPrefsHelper.saveFetchingTime();
          return _weatherInfo;
        }
      }

      /// call data in a new day
      else {
        _weatherInfo = await _weatherApi.getWeatherInfo(params: params);
        await _sharedPrefsHelper.saveWeather(_weatherInfo);
        await _sharedPrefsHelper.saveFetchingTime();
        return _weatherInfo;
      }
    }

    /// first time
    else {
      _weatherInfo = await _weatherApi.getWeatherInfo(params: params);
      await _sharedPrefsHelper.saveWeather(_weatherInfo);
      await _sharedPrefsHelper.saveFetchingTime();
      return _weatherInfo;
    }
  }

  Future<int> insert(WeatherForecastListResponse post) => _weatherDataSource
      .insert(post)
      .then((id) => id)
      .catchError((error) => throw error);

  // Future<int> update(WeatherForecastListResponse post) => _weatherDataSource
  //     .update(post)
  //     .then((id) => id)
  //     .catchError((error) => throw error);
  //
  // Future<int> delete(Post post) => _weatherDataSource
  //     .update(post)
  //     .then((id) => id)
  //     .catchError((error) => throw error);


  // Login:---------------------------------------------------------------------
  // Future<bool> login(String email, String password) async {
  //   return await Future.delayed(Duration(seconds: 2), ()=> true);
  // }
  //
  // Future<void> saveIsLoggedIn(bool value) =>
  //     _sharedPrefsHelper.saveIsLoggedIn(value);
  //
  // Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}