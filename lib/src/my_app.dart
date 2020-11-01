import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    String timeStamp =
        DateFormat('dd/MM/yyyy hh:mm:ss').format(DateTime.now()).toString();

    setState(() {
      Timer.periodic(Duration(seconds: 1), (v) {
        setState(() {
          timeStamp = DateFormat('dd/MM/yyyy hh:mm:ss')
              .format(DateTime.now())
              .toString(); // or BinaryTime see next step
        });
      });
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("My App"),
        ),
        endDrawer: Drawer(
          child: ListTile(
            title: Text("Hello"),
          ),
        ),
        body: ListView(
          children: [
            Container(margin: EdgeInsets.all(10.0)),
            Center(
              child: Text(
                "Hello World!!!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            Container(margin: EdgeInsets.all(10.0)),
            Center(
              child: Text(
                timeStamp,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      ),
    );
  }
}
