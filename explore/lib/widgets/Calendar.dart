import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

void main() => runApp(MyCalendarApp());

class MyCalendarApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Calendar'),
        ),
        body: Container(
          child: Calendar(
            isExpandable: true,
            onDateSelected: (DateTime dateTime) {
              print(dateTime);
            },
          ),
        ),
      ),
    );
  }
}