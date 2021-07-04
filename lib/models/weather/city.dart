import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  final int? id;
  final String? name;
  final int? timezone;
  final int? sunrise;
  final int? sunset;

  City({this.name, this.id, this.sunrise, this.sunset, this.timezone});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
