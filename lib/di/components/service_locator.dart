import 'package:morphosis_flutter_demo/data/local/datasources/weather/weather_datasource.dart';
import 'package:morphosis_flutter_demo/data/network/dio_client.dart';
import 'package:morphosis_flutter_demo/data/network/rest_client.dart';
import 'package:morphosis_flutter_demo/data/network/task/task_firestore.dart';
import 'package:morphosis_flutter_demo/data/network/weather/weather_api.dart';
import 'package:morphosis_flutter_demo/data/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/data/repo/firestore_service_manager.dart';
import 'package:morphosis_flutter_demo/data/repository.dart';
import 'package:morphosis_flutter_demo/data/sharedpref/shared_preference_helper.dart';
import 'package:morphosis_flutter_demo/data/task_repository.dart';
import 'package:morphosis_flutter_demo/di/module/local_module.dart';
import 'package:morphosis_flutter_demo/di/module/network_module.dart';
import 'package:morphosis_flutter_demo/stores/error/error_store.dart';
import 'package:morphosis_flutter_demo/stores/form/form_store.dart';
import 'package:morphosis_flutter_demo/stores/language/language_store.dart';
import 'package:morphosis_flutter_demo/stores/theme/theme_store.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());
  getIt.registerFactory(() => FormStore());

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(() => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());
  // getIt.registerFactory(() => FirebaseManager());
  getIt.registerSingleton(TaskFireStore());
  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(WeatherApi(getIt<DioClient>(), getIt<RestClient>()));

  // data sources
  getIt.registerSingleton(WeatherDataSource(await getIt.getAsync<Database>()));


  getIt.registerLazySingleton(() => FirebaseManager());

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
    getIt<WeatherApi>(),
    getIt<SharedPreferenceHelper>(),
    getIt<WeatherDataSource>(),
  ));

  // task repository:----------------------------------------------------------------
  getIt.registerSingleton(TaskRepository(
    getIt<TaskFireStore>(),
    getIt<SharedPreferenceHelper>(),
   // getIt<FirebaseManager>(),
  ));

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));

  // getIt.registerSingleton(WeatherBloc());
 // getIt.registerSingleton(PostStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));

}
