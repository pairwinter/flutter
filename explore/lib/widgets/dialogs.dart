import 'package:flutter/material.dart';
import 'dialogs_full_screen.dart';
void main() => (runApp(DialogsTestApp()));

class DialogsTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: DialogsTestPage(),
    );
  }
}

class DialogsTestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogsTestPageState();
  }
}

class DialogsTestPageState extends State<DialogsTestPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(context: context, builder: (BuildContext context) => child)
        .then<void>((T value) {
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('You selected: $value'),
          duration: Duration(seconds: 2),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Dialog Demos'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
              child: const Text('ALERT'),
              onPressed: () {
                showDemoDialog<DialogDemoAction>(
                    context: context,
                    child: AlertDialog(
                      title: Text('This is title!'),
                      content: Text('Discard?'),
                      actions: <Widget>[
                        FlatButton(
                          child: const Text('CANCEL'),
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.cancel);
                          },
                        ),
                        FlatButton(
                          child: const Text('DISCARD'),
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.discard);
                          },
                        )
                      ],
                    ));
              }),
          RaisedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return FullScreenDialogDemo();
            }, fullscreenDialog: true));
          })
        ],
      ),
    );
  }
}

enum DialogDemoAction { cancel, discard, disagree, agree }
