import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../const.dart';
import '../login.dart';

class Choice {
  final String text;
  final IconData iconData;
  const Choice(this.text, this.iconData);
}
List<Choice> choices = const <Choice>[
  Choice('Settings', Icons.settings),
  Choice('Exit', Icons.power_settings_new),
  Choice('Log out', Icons.exit_to_app),
];

void _onItemMenuPress(BuildContext context, Choice choice) async{
  if(choice.text == 'Exit'){
    return _signOut();
  } else if(choice.text == 'Settings'){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Text('Settings')));
  } else if(choice.text == 'Log out'){
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }
}

void _signOut(){

}

Widget buildAppBar(BuildContext context){
  return AppBar(
    title: Text(
      'Main',
      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    actions: <Widget>[
      PopupMenuButton<Choice>(
        onSelected: (choice){
          _onItemMenuPress(context, choice);
        },
        itemBuilder: (BuildContext context) {
          return choices.map((Choice choice) {
            return PopupMenuItem<Choice>(
              value: choice,
              child: Row(
                children: <Widget>[
                  Icon(
                    choice.iconData,
                    color: primaryColor,
                  ),
                  Container(
                    width: 10.0,
                  ),
                  Text(
                    choice.text,
                    style: TextStyle(color: primaryColor),
                  )
                ],
              ),
            );
          }).toList();
        },
      )
    ],
  );
}