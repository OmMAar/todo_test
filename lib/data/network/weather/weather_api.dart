import 'dart:async';

import 'package:morphosis_flutter_demo/data/network/constants/endpoints.dart';
import 'package:morphosis_flutter_demo/data/network/dio_client.dart';
import 'package:morphosis_flutter_demo/data/network/rest_client.dart';
import 'package:morphosis_flutter_demo/models/weather/weather_forecast_list_response.dart';

class WeatherApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  WeatherApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<WeatherForecastListResponse> getWeatherInfo({required Map<String, dynamic> params}) async {
    try {
      final res = await _dioClient.get(Endpoints.weatherInfoUrl,queryParameters: params);
      return WeatherForecastListResponse.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Future<WeatherForecastListResponse> getWeatherInfo(
  //     {required Map<String, dynamic> params}) async {
  //   return execute<WeatherForecastListResponse>(() async {
  //     /// Send the request.
  //     ///
  //
  //     print(' request: ${Endpoints.weatherInfoUrl} params: $params');
  //     final res = await dioClient.get(
  //       url: Endpoints.weatherInfoUrl,
  //       params: params,
  //     );
  //
  //     /// Check request success.
  //     if (res['cod'] != '200') {
  //       throw handleCustomError(res['cod']);
  //     }
  //
  //     print(' response: ${Endpoints.weatherInfoUrl} params: $res');
  //
  //     /// Convert data.
  //     final info = WeatherForecastListResponse.fromJson(res);
  //     return info;
  //   });
  // }

/// sample api call with default rest client
//  Future<PostsList> getPosts() {
//
//    return _restClient
//        .get(Endpoints.getPosts)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}
