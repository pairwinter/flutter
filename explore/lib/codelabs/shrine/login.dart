import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  FocusNode focusNode;
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _isFilled = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(
              height: 80.0,
            ),
            Column(
              children: <Widget>[
                Image.asset('assets/logo.png'),
                SizedBox(
                  height: 20.0,
                ),
                Text('SHRINE')
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            TextField(
              focusNode: focusNode,
              controller: _usernameTextController,
              decoration: InputDecoration(filled: true, labelText: 'Username'),
              onChanged: (String text) {
                this.setState(() {
                  _isFilled = text.trim().length > 0 &&
                      _passwordTextController.text.trim().length > 0;
                });
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: _passwordTextController,
              decoration: InputDecoration(filled: true, labelText: 'Password'),
              onChanged: (String text) {
                this.setState(() {
                  _isFilled = text.trim().length > 0 &&
                      _usernameTextController.text.trim().length > 0;
                });
              },
              obscureText: true,
            ),
            SizedBox(
              height: 10.0,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      _usernameTextController.clear();
                      _passwordTextController.clear();
                      FocusScope.of(context).requestFocus(focusNode);
                      this.setState(() {
                        _isFilled = false;
                      });
                    },
                    child: Text('Cancel')),
                RaisedButton(
                  onPressed: _isFilled ? () {} : null,
                  child: Text('Next'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
