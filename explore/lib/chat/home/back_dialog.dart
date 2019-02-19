import 'dart:async';
import 'package:flutter/material.dart';
import '../const.dart';

Future<int> openBackDialog(BuildContext context) async {
  int result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Container(
              color: themeColor,
              height: 60.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.exit_to_app,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Exit app',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Text(
                    'Are you sure to exit app?',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context, 0);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.cancel,
                          color: primaryColor,
                        ),
                        margin: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                      ),
                      Text(
                        'Cancel',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context, 1);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.check_circle,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        'Yes',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      });
  return result;
}
