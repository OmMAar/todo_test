import 'package:json_annotation/json_annotation.dart';
import 'package:morphosis_flutter_demo/models/weather/clouds.dart';
import 'package:morphosis_flutter_demo/models/weather/main_data.dart';
import 'package:morphosis_flutter_demo/models/weather/weather_data.dart';
import 'package:morphosis_flutter_demo/models/weather/wind.dart';

part 'weather_forecast.g.dart';

@JsonSerializable()
class WeatherForecast {
  @JsonKey(name: 'main')
  final MainData? mainData;
  @JsonKey(name: 'weather')
  final List<WeatherData>? weatherData;
  final Clouds? clouds;
  final Wind? wind;
  @JsonKey(name: 'dt_txt')
  final DateTime? dateTime;

  WeatherForecast(
      {this.mainData, this.dateTime, this.clouds, this.weatherData, this.wind});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastToJson(this);
}
