import 'package:flutter/material.dart';

class City {
  final String cityName;
  final List<dynamic> coordinates;
  final String time1;
  final double air_temperature1;
  final double relative_humidity1;
  final double wind_speed1;
  final String time2;
  final double air_temperature2;
  final double relative_humidity2;
  final double wind_speed2;
  final String time3;
  final double air_temperature3;
  final double relative_humidity3;
  final double wind_speed3;

  City(
      {this.cityName,
      this.coordinates,
      this.time1,
      this.air_temperature1,
      this.relative_humidity1,
      this.wind_speed1,
      this.time2,
      this.air_temperature2,
      this.relative_humidity2,
      this.wind_speed2,
      this.time3,
      this.air_temperature3,
      this.relative_humidity3,
      this.wind_speed3});

  factory City.fromJson(Map<String, dynamic> json, cityName) {
    return City(
      cityName: cityName,
      coordinates: json['geometry']['coordinates'] as List<dynamic>,
      //for today:
      time1: json['properties']['timeseries'][0]['time'] as String,
      air_temperature1: json['properties']['timeseries'][0]['data']['instant']
          ['details']['air_temperature'] as double,
      relative_humidity1: json['properties']['timeseries'][0]['data']['instant']
          ['details']['relative_humidity'] as double,
      wind_speed1: json['properties']['timeseries'][0]['data']['instant']
          ['details']['wind_speed'] as double,
      //for tomorrow:
      time2: json['properties']['timeseries'][24]['time'] as String,
      air_temperature2: json['properties']['timeseries'][24]['data']['instant']
          ['details']['air_temperature'] as double,
      relative_humidity2: json['properties']['timeseries'][24]['data']['instant']
          ['details']['relative_humidity'] as double,
      wind_speed2: json['properties']['timeseries'][24]['data']['instant']
          ['details']['wind_speed'] as double,
      //in 2 days:
      time3: json['properties']['timeseries'][48]['time'] as String,
      air_temperature3: json['properties']['timeseries'][48]['data']['instant']
          ['details']['air_temperature'] as double,
      relative_humidity3: json['properties']['timeseries'][48]['data']['instant']
          ['details']['relative_humidity'] as double,
      wind_speed3: json['properties']['timeseries'][48]['data']['instant']
          ['details']['wind_speed'] as double,
    );
  }
}

class CityFromAutoComplete {
  String cityName;
  double cityLat;
  double cityLng;

  CityFromAutoComplete(this.cityName, this.cityLat, this.cityLng);
}
