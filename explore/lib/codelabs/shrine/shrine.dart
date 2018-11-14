import 'package:flutter/material.dart';

import 'login.dart';

void main() => runApp(Shrine());

class Shrine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}
