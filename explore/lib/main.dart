import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
        ),
        body: Center(
          child: Text('home->body->Center>child(Text)'),
        ),
      ),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}
