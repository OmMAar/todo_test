// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherForecast _$WeatherForecastFromJson(Map<String, dynamic> json) {
  return WeatherForecast(
    mainData: json['main'] == null
        ? null
        : MainData.fromJson(json['main'] as Map<String, dynamic>),
    dateTime: json['dt_txt'] == null
        ? null
        : DateTime.parse(json['dt_txt'] as String),
    clouds: json['clouds'] == null
        ? null
        : Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
    weatherData: (json['weather'] as List<dynamic>?)
        ?.map((e) => WeatherData.fromJson(e as Map<String, dynamic>))
        .toList(),
    wind: json['wind'] == null
        ? null
        : Wind.fromJson(json['wind'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WeatherForecastToJson(WeatherForecast instance) =>
    <String, dynamic>{
      'main': instance.mainData,
      'weather': instance.weatherData,
      'clouds': instance.clouds,
      'wind': instance.wind,
      'dt_txt': instance.dateTime?.toIso8601String(),
    };
