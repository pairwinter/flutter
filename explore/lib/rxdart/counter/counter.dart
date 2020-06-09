import 'package:flutter/material.dart';
import 'CounterBloc.dart';

// https://medium.com/flutter-community/why-use-rxdart-and-how-we-can-use-with-bloc-pattern-in-flutter-a64ca2c7c52d
void main() => runApp(new RxDartStartApp());

class RxDartStartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RxDart',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  CounterBloc _counterBloc = new CounterBloc(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rxdart')),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('You have pushed button this many times: '),
            StreamBuilder(
                stream: _counterBloc.counterObserve,
                builder: (context, AsyncSnapshot<int> snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.display1,
                  );
                })
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: FloatingActionButton(
              onPressed: _counterBloc.increment,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ),
          FloatingActionButton(
            onPressed: _counterBloc.decrement,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
