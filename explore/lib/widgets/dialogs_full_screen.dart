import 'package:flutter/material.dart';

enum DismissDialogAction { cancel, discard, save }

class FullScreenDialogDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FullScreenDialogDemoState();
  }
}

class FullScreenDialogDemoState extends State<FullScreenDialogDemo> {
  DateTime _fromDateTime = DateTime.now();
  DateTime _toDateTime = DateTime.now();

  bool _allDayValue = false;
  bool _saveNeeded = false;
  bool _hasLocation = false;
  bool _hasName = false;

  String _eventName;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_hasName ? _eventName : 'Event Name TBD'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'SAVE',
              style: themeData.textTheme.body1.copyWith(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context, DismissDialogAction.save);
            },
          )
        ],
      ),
      body: Form(
//          onWillPop: ,
          child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Event name',
                hintText: 'What\'s the Event name?',
                filled: true,
              ),
              style: themeData.textTheme.headline,
              onChanged: (String value) {
                setState(() {
                  _hasName = value.isNotEmpty;
                  if (_hasName) {
                    _eventName = value;
                  }
                });
              },
            ),
          )
        ],
      )),
    );
  }
}
