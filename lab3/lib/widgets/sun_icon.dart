import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SunIcon extends StatefulWidget {
  @override
  _SunIconState createState() => _SunIconState();
}

class _SunIconState extends State<SunIcon> with TickerProviderStateMixin {
  Animation<double> sunAnimation;
  AnimationController sunController;

  @override
  void initState() {
    super.initState();
    sunController = AnimationController(
        duration: Duration(seconds: 5),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 2 * 3.14);
    sunAnimation = Tween(begin: 0.0, end: 1.0).animate(sunController);
    sunController.repeat();
  }

  @override
  void dispose() {
    sunController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
            animation: sunAnimation,
            builder: (BuildContext context, Widget _widget) {
              return new Transform.rotate(
                angle: sunAnimation.value,
                child: _widget,
              );
            },
            child: Image.asset("assets/sun.png", height: 100, width: 100)),
        Container(
            margin: EdgeInsets.only(left: 30, top: 30),
            child: Image.asset("assets/eye_open.png",
                height: 20, width: 20, color: Colors.black)),
        Container(
            margin: EdgeInsets.only(left: 50, top: 30),
            child: Image.asset("assets/eye_open.png",
                height: 20, width: 20, color: Colors.black)),
      ],
    );
  }
}
