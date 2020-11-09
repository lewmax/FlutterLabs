import 'dart:async';

import 'package:intl/intl.dart';

class ClockBlock {
  String _timeStamp = DateFormat('dd/MM/yyyy hh:mm:ss').format(DateTime.now());

  final _streamController = StreamController<String>();

  Stream<String> get clockStream => _streamController.stream;

  void updateTime() {
    Timer.periodic(Duration(seconds: 1), (v) {
      _timeStamp = DateFormat('dd/MM/yyyy hh:mm:ss')
          .format(DateTime.now())
          .toString(); // or BinaryTime see next step
      _streamController.sink.add(_timeStamp);
    });
  }

  void dispose() {
    _streamController.close();
  }
}
