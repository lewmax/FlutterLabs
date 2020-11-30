import 'dart:async';

class CounterBloc {
  int _counter = 0;

  final _streamController = StreamController<int>();

  Stream<int> get counterStream => _streamController.stream;

  void updateCounter() {
    _streamController.sink.add(++_counter);
    print(_counter);
  }

  void dispose() {
    _streamController.close();
  }
}