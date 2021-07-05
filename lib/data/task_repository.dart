import 'dart:async';
import 'package:morphosis_flutter_demo/data/network/task/task_firestore.dart';
import 'package:morphosis_flutter_demo/data/sharedpref/shared_preference_helper.dart';
import 'package:morphosis_flutter_demo/models/task/task.dart';

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

  // edit task: ---------------------------------------------------------------------
  Future<bool> editTask(
      {required Task task}) async {
    final result = await _taskFireStore.editTask(task: task);
    return result;

  }

  // delete task: ---------------------------------------------------------------------
  Future<bool> deleteTask(
      {required String id}) async {
    final result = await _taskFireStore.deleteTask(id: id);
    return result;

  }

}