import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salam/bloc/clock_bloc.dart';

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _clockBloc = ClockBlock();

  @override
  Widget build(BuildContext context) {
    _clockBloc.updateTime();
    final int percent = (_controller.value * 100.0).round();
    return Container(
      child: ListView(
        children: [
          Text("Page Two"),
          Container(margin: EdgeInsets.all(10.0)),
          StreamBuilder(
            initialData: DateFormat('dd/MM/yyyy hh:mm:ss')
                .format(DateTime.now())
                .toString(),
            stream: _clockBloc.clockStream,
            builder: (context, snapshot) {
              return Center(
                  child:
                      Text('${snapshot.data}', style: TextStyle(fontSize: 25)));
            },
          ),
          Text(
            "123",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          TweenAnimationBuilder(
            duration: Duration(milliseconds: 500),
            tween: Tween<double>(begin: 0, end: 2 * 3.14),
            builder: (_, double angle, __) {
              return Transform.rotate(
                angle: angle,
                child: Icon(Icons.hail, size: 100),
              );
            },
          ),
          Center(
            child: Text('$percent%'),
          )
        ],
      ),
    );
  }
}
