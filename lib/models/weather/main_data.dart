import 'package:json_annotation/json_annotation.dart';

part 'main_data.g.dart';

@JsonSerializable()
class MainData {
  final double? temp;
  final double? pressure;
  final double? humidity;
  @JsonKey(name: 'temp_min')
  final double? tempMin;
  @JsonKey(name: 'temp_max')
  final double? tempMax;
  @JsonKey(name: 'sea_level')
  final double? pSeaLevel;
  @JsonKey(name: 'ground_level')
  final double? pGroundLevel;

  MainData(
      {this.temp,
      this.pressure,
      this.humidity,
      this.tempMin,
      this.tempMax,
      this.pSeaLevel,
      this.pGroundLevel});

  factory MainData.fromJson(Map<String, dynamic> json) =>
      _$MainDataFromJson(json);

  Map<String, dynamic> toJson() => _$MainDataToJson(this);
}
