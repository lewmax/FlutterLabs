import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:salam/bloc/navigation_bloc.dart';
import 'package:salam/src/page_one.dart';

class City {
  List<double> coordinates;
  String time;
  double air_temperature;
  double relative_humidity;
  double wind_speed;

  City(
      {this.coordinates,
      this.time,
      this.air_temperature,
      this.relative_humidity,
      this.wind_speed});

  City.fromJson(parsedJson) {
    coordinates = parsedJson['geometry']['coordinates'];
    time = parsedJson['properties']['timeseries']['data']['instant']['details']
        ['time'];
    air_temperature = parsedJson['properties']['timeseries']['data']['instant']
        ['details']['air_temperature'];
    relative_humidity = parsedJson['properties']['timeseries']['data']
        ['instant']['details']['relative_humidity'];
    wind_speed = parsedJson['properties']['timeseries']['data']['instant']
        ['details']['wind_speed'];
  }
}

class CityList extends StatelessWidget {
  final List<City> cities;

  CityList(this.cities);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, int index) {
        return Text(cities[0].coordinates.toString());
      },
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  List<City> cities = [];

  // fetchCity() async {
  //   var response = await get(
  //       'https://api.met.no/weatherapi/locationforecast/2.0/compact.json?altitude=296&lat=49.84&lon=24.03');
  //   var cityModel = City.fromJson(json.decode(response.body));
  //   print(cityModel.air_temperature);
  //   print(cityModel.coordinates);
  //   print(cityModel.relative_humidity);
  //   print(cityModel.time);
  //   print(cityModel.wind_speed);
  //
  //   setState(() {
  //     cities.add(cityModel);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Isolate Demo';
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.navigate_next),
              onPressed: navigationBloc.changeScreen,
            ),
            body: StreamBuilder(
              initialData: PageOne(),
              stream: navigationBloc.screen,
              builder: (context, snapshot) {
                return snapshot.data;
              },
            )));
  }
}
