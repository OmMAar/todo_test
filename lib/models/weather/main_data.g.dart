// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainData _$MainDataFromJson(Map<String, dynamic> json) {
  return MainData(
    temp: (json['temp'] as num?)?.toDouble(),
    pressure: (json['pressure'] as num?)?.toDouble(),
    humidity: (json['humidity'] as num?)?.toDouble(),
    tempMin: (json['temp_min'] as num?)?.toDouble(),
    tempMax: (json['temp_max'] as num?)?.toDouble(),
    pSeaLevel: (json['sea_level'] as num?)?.toDouble(),
    pGroundLevel: (json['ground_level'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$MainDataToJson(MainData instance) => <String, dynamic>{
      'temp': instance.temp,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'sea_level': instance.pSeaLevel,
      'ground_level': instance.pGroundLevel,
    };
