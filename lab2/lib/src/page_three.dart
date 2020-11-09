import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'package:salam/objects/city.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class PageThree extends StatefulWidget {
  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  String cityFromAutocomplete = '';

  List<City> cities = [];

  void fetchCity(double lat, double lng, String cityName) async {
    var result = await http.get(
        'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=$lat&lon=$lng');

    City city = City.fromJson(jsonDecode(result.body), cityName);

    setState(() {
      cities.add(city);
    });
    print("Lat/Lng: ${city.coordinates[1]}/${city.coordinates[0]}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromRGBO(18, 33, 88, 1), Color.fromRGBO(146, 95, 160, 1)])),
      child: Stack(
        children: [
          ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemBuilder: (context, index) {
              return Dismissible(
                  background: Container(
                      padding: EdgeInsets.only(left: 15),
                      color: Colors.red,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ))),
                  resizeDuration: Duration(milliseconds: 600),
                  key: ValueKey(cities[index].cityName),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    String nameOfDeleted = cities[index].cityName;
                    setState(() {
                      cities.removeAt(index);
                    });
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("$nameOfDeleted dismissed")));
                  },
                  confirmDismiss: (direction) async {
                    return await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Warning'),
                            content: Text('Delete this note?'),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('Yes')),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('No'))
                            ],
                          );
                        });
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(cities[index].cityName,
                        style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300)),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('${cities[index].time1}'.substring(5, 10),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 22, color: Colors.white)),
                            // Text('${cities[index].time1}'),
                            Text('${cities[index].air_temperature1}°',
                                style: TextStyle(fontSize: 19, color: Colors.white)),
                            Text('${cities[index].relative_humidity1}%',
                                style: TextStyle(fontSize: 19, color: Colors.white)),
                            Text('${cities[index].wind_speed1}m/s',
                                style: TextStyle(fontSize: 19, color: Colors.white)),
                          ],
                        ),
                        Column(
                          children: [
                            Text('${cities[index].time2}'.substring(5, 10),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 22, color: Colors.white)),
                            // Text('${cities[index].time2}'),
                            Text('${cities[index].air_temperature2}°',
                                style: TextStyle(fontSize: 19, color: Colors.white)),
                            Text('${cities[index].relative_humidity2}%',
                                style: TextStyle(fontSize: 19, color: Colors.white)),
                            Text('${cities[index].wind_speed2}m/s',
                                style: TextStyle(fontSize: 19, color: Colors.white)),
                          ],
                        ),
                        Column(
                          children: [
                            Text('${cities[index].time3}'.substring(5, 10),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 22, color: Colors.white)),
                            // Text('${cities[index].time3}'.substring(5, 10)),
                            Text('${cities[index].air_temperature3}°',
                                style: TextStyle(fontSize: 19, color: Colors.white)),
                            Text('${cities[index].relative_humidity3}%',
                                style: TextStyle(fontSize: 19, color: Colors.white)),
                            Text('${cities[index].wind_speed3}m/s',
                                style: TextStyle(fontSize: 19, color: Colors.white)),
                          ],
                        )
                      ],
                    ),
                    // onTap: () {
                    //   navigationBloc.screenController.sink.add(NoteView());
                    // },
                  ));
            },
            itemCount: cities.length,
          ),
          Positioned(
            child: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: Colors.blue,
                onPressed: () async {
                  Prediction prediction = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: 'AIzaSyB5HJF1LhRV-gCTquYMFuz14hQ9_NyeCK4',
                      mode: Mode.overlay,
                      language: "en",
                      hint: 'Search city');
                  if (prediction != null) {
                    getLatLng(prediction);
                    cityFromAutocomplete = prediction.description;
                    print(cityFromAutocomplete);
                  }
                }),
            left: 15,
            bottom: 15,
          )
        ],
      ),
    );
  }

  void getLatLng(Prediction prediction) async {
    GoogleMapsPlaces _places =
        new GoogleMapsPlaces(apiKey: "AIzaSyB5HJF1LhRV-gCTquYMFuz14hQ9_NyeCK4");
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(prediction.placeId);
    double latitude = detail.result.geometry.location.lat;
    double longitude = detail.result.geometry.location.lng;
    String address = prediction.description;

    fetchCity(latitude, longitude, address);
  }
}
