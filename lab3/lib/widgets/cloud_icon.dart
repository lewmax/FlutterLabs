import 'package:flutter/material.dart';

class CloudIcon extends StatefulWidget {
  @override
  _CloudIconState createState() => _CloudIconState();
}

class _CloudIconState extends State<CloudIcon>
    with SingleTickerProviderStateMixin {
  Animation<double> cloudAnimation;
  AnimationController cloudController;

  @override
  void initState() {
    super.initState();
    cloudController = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0);
    cloudAnimation = Tween(begin: 0.9, end: 1.1).animate(cloudController);

    cloudController.repeat(reverse: true);
  }

  @override
  void dispose() {
    cloudController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: cloudAnimation,
        builder: (BuildContext context, Widget child) {
          return new Transform.scale(
            scale: cloudAnimation.value,
            child: child,
          );
        },
        child: Image.asset("assets/cloud.png", height: 100, width: 100));
  }
}
