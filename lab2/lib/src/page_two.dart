import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salam/bloc/clock_bloc.dart';

class PageTwo extends StatelessWidget {
  final _clockBloc = ClockBlock();

  @override
  Widget build(BuildContext context) {

    _clockBloc.updateTime();

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
          )
        ],
      ),
    );
  }
}
