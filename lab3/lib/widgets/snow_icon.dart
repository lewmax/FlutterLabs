import 'package:flutter/material.dart';

class SnowIcon extends StatefulWidget {
  bool reverse;

  SnowIcon({this.reverse});

  @override
  _SnowIconState createState() => _SnowIconState();
}

class _SnowIconState extends State<SnowIcon>
    with SingleTickerProviderStateMixin {
  Animation<double> snowAnimation;
  AnimationController snowController;

  @override
  void initState() {
    super.initState();
    snowController = AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0);
    snowAnimation = Tween(begin: 0.0, end: 40.0).animate(snowController);

    Future.delayed(Duration(seconds: widget.reverse ? 1 : 0), () {
      setState(() {
        snowController.repeat(reverse: true);
      });
    });
  }

  @override
  void dispose() {
    snowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: snowAnimation,
        builder: (context, child) {
          return Container(
            child: child,
            margin: EdgeInsets.only(top: snowAnimation.value, left: 5.0),
          );
        },
        child: Image.asset('assets/snow.png', height: 20, width: 20));
  }
}
