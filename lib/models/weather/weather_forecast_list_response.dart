import 'package:json_annotation/json_annotation.dart';
import 'package:morphosis_flutter_demo/models/weather/city.dart';
import 'package:morphosis_flutter_demo/models/weather/weather_forecast.dart';

part 'weather_forecast_list_response.g.dart';

@JsonSerializable()
class WeatherForecastListResponse {
  final List<WeatherForecast>? list;
  final City? city;
  final String? cod;

  WeatherForecastListResponse({this.list, this.city, this.cod});

  factory WeatherForecastListResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastListResponseToJson(this);
}
