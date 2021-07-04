import 'dart:async';

import 'package:morphosis_flutter_demo/data/network/constants/endpoints.dart';
import 'package:morphosis_flutter_demo/data/network/dio_client.dart';
import 'package:morphosis_flutter_demo/data/network/rest_client.dart';
import 'package:morphosis_flutter_demo/data/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/data/repo/firestore_service_manager.dart';
import 'package:morphosis_flutter_demo/di/components/service_locator.dart';
import 'package:morphosis_flutter_demo/models/task/task.dart';
import 'package:morphosis_flutter_demo/models/weather/weather_forecast_list_response.dart';
import 'package:morphosis_flutter_demo/utils/dio/dio_error_util.dart';

class TaskFireStore {




  // injecting dio instance
  TaskFireStore();

  /// add task
  Future addTask({required Task task})async {
    var result = await getIt<FirebaseManager>().addTask(task);


    if (result is String){
      return false;
    }else{
      return true;
    }
  }


}
