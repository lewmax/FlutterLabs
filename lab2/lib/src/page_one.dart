import 'package:flutter/material.dart';
import 'package:salam/bloc/counter%20bloc.dart';

class PageOne extends StatelessWidget {
  final _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Text("Page One"),
          StreamBuilder(
            initialData: 0,
            stream: _counterBloc.counterStream,
            builder: (context, snapshot) {
              return Text('${snapshot.data}');
            },
          ),
          MaterialButton(
            color: Colors.blueAccent,
              child: Icon(Icons.add),
              onPressed: () {
                _counterBloc.updateCounter();
              })
        ],
      ),
    );
  }
}
