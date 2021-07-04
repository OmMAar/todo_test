import 'dart:async';

import 'package:morphosis_flutter_demo/constants/app_config.dart';
import 'package:morphosis_flutter_demo/data/network/task/task_firestore.dart';
import 'package:morphosis_flutter_demo/data/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/data/sharedpref/shared_preference_helper.dart';
import 'package:morphosis_flutter_demo/models/task/task.dart';
import 'package:morphosis_flutter_demo/models/weather/weather_forecast_list_response.dart';

import 'local/datasources/weather/weather_datasource.dart';
import 'network/weather/weather_api.dart';

class TaskRepository {
  // data source object

  // api objects
  final TaskFireStore _taskFireStore;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  TaskRepository(this._taskFireStore, this._sharedPrefsHelper);

  // add task: ---------------------------------------------------------------------
  Future<bool> addTask(
      {required Task task}) async {
    final result = await _taskFireStore.addTask(task: task);
    return result;

  }

}