// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherForecastListResponse _$WeatherForecastListResponseFromJson(
    Map<String, dynamic> json) {
  return WeatherForecastListResponse(
    list: (json['list'] as List<dynamic>?)
        ?.map((e) => WeatherForecast.fromJson(e as Map<String, dynamic>))
        .toList(),
    city: json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    cod: json['cod'] as String?,
  );
}

Map<String, dynamic> _$WeatherForecastListResponseToJson(
        WeatherForecastListResponse instance) =>
    <String, dynamic>{
      'list': instance.list,
      'city': instance.city,
      'cod': instance.cod,
    };
