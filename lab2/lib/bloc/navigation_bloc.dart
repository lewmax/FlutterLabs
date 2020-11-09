import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:salam/src/page_one.dart';
import 'package:salam/src/page_three.dart';
import 'package:salam/src/page_two.dart';

class NavigationBloc {
  int screenId = 1;

  final screenController = StreamController<Widget>.broadcast();

  Stream<Widget> get screen => screenController.stream;

  void changeScreen() {
    if(screenId == 1) {
      screenId++;
      screenController.sink.add(PageTwo());
    } else if(screenId == 2){
      screenId++;
      screenController.sink.add(PageThree());
    } else if(screenId == 3) {
      screenId = 1;
      screenController.sink.add(PageOne());
    }
  }

  void dispose() {
    screenController.close();
  }
}

final navigationBloc = NavigationBloc();