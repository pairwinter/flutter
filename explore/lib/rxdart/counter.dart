import 'package:flutter/material.dart';

void main() => runApp(new RxDartStartApp());

class RxDartStartApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RxDart',
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
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

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter += 1;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Rxdart')
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('You have pushed button this many times: '),
            Text('$_counter', style: Theme
                .of(context)
                .textTheme
                .display1,)
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ),
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
