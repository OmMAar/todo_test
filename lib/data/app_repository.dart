import 'dart:async';
import 'package:morphosis_flutter_demo/data/sharedpref/shared_preference_helper.dart';



class AppRepository {

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  AppRepository(this._sharedPrefsHelper);


  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}