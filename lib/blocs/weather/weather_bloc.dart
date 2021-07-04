import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:morphosis_flutter_demo/data/repository.dart';
import 'package:morphosis_flutter_demo/di/components/service_locator.dart';
import 'package:morphosis_flutter_demo/models/weather/weather_forecast_list_response.dart';
import 'package:morphosis_flutter_demo/utils/dio/dio_error_util.dart';


abstract class WeatherState extends Equatable {}

class WeatherUninitialized extends WeatherState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'WeatherUninitialized';
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'WeatherLoading';
}

class WeatherSuccess extends WeatherState {
 final WeatherForecastListResponse result;

   WeatherSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'WeatherSuccess data :${result.toJson()}';
}

class WeatherFailure extends WeatherState {
  final String errorMessage;
  final VoidCallback? callback;

  WeatherFailure({
    required this.errorMessage,
    this.callback,
  });

  @override
  List<Object> get props => [errorMessage, callback!];

  @override
  String toString() => 'WeatherFailure { error: $errorMessage }';
}

// abstract class WeatherEvent extends Equatable {}

class WeatherEvent extends Equatable {


  @override
  List<Object> get props => [];

  @override
  String toString() => 'WeatherEvent';
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherUninitialized());



  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // repository instance
    Repository _repository = getIt<Repository>();


    yield WeatherLoading();


    try {
      final future = await _repository.getWeatherInfo(params: {
        'id': '292223',
        'appid': '6b8c1510f8cf4cbbfbbdcc4e7370ff21'
      });

      yield WeatherSuccess(result: future);
    } catch (err) {
      print('Caught error: $err');
      yield WeatherFailure(
        errorMessage: DioErrorUtil.handleError(err as DioError),
        callback: () {
          this.add(event);
        },
      );
    }



    // yield await _repository.getWeatherInfo(params: {
    //   'id': '292223',
    //   'appid': '6b8c1510f8cf4cbbfbbdcc4e7370ff21'
    // }).then((response) {
    //   return WeatherSuccess(result: response);
    // }).catchError((error) {
    //   return  WeatherFailure(
    //     errorMessage: DioErrorUtil.handleError(error),
    //     callback: () {
    //       this.add(event);
    //     },
    //   );
    // });
    //
    // future.then((postList){
    //   //    this.postList = postList;
    //   return WeatherSuccess(result: postList);
    // }).catchError((error) {
    //   // ignore: return_of_invalid_type_from_catch_error
    //   return WeatherFailure(
    //     errorMessage: DioErrorUtil.handleError(error),
    //     callback: () {
    //       this.add(event);
    //     },
    //   );
    //   //  errorStore.errorMessage = DioErrorUtil.handleError(error);
    // });
    // yield WeatherLoading();
    // final result = await WeatherUseCase(locator<UserRepository>())(
    //   WeatherParams(
    //     queryParams: WeatherRequest(
    //       username: event.email,
    //     ),
    //     cancelToken: event.cancelToken,
    //   ),
    // );
    // if (result.hasDataOnly) {
    //   yield WeatherSuccess();
    // }
    // if (result.hasErrorOnly) {
    //   yield WeatherFailure(
    //     error: result.error!,
    //     callback: () {
    //       this.add(event);
    //     },
    //   );
    // }
  }
}
