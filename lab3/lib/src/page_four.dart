import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salam/bloc/clock_bloc.dart';
import 'package:salam/widgets/cat.dart';

class PageFour extends StatefulWidget {
  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  @override
  void initState() {
    super.initState();

    catController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    catAnimation = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(parent: catController, curve: Curves.easeIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GestureDetector(
          child: buildAnimation(),
          onTap: () {
            if (catAnimation.status == AnimationStatus.completed) {
              catController.reverse();
            } else if (catAnimation.status == AnimationStatus.dismissed) {
              catController.forward();
            }
          },
        ),
      ],
    );
  }

  Widget buildAnimation() {
    return AnimatedBuilder(
        animation: catAnimation,
        builder: (context, child) {
          return Container(
            child: child,
            margin: EdgeInsets.only(top: catAnimation.value),
          );
        },
        child: Cat());
  }
}
