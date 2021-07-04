// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
    name: json['name'] as String?,
    id: json['id'] as int?,
    sunrise: json['sunrise'] as int?,
    sunset: json['sunset'] as int?,
    timezone: json['timezone'] as int?,
  );
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'timezone': instance.timezone,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
