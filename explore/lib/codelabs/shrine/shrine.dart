import 'package:flutter/material.dart';

import 'supplemental/cut_corners_border.dart';
import 'login.dart';
import 'home.dart';
import 'colors.dart';

void main() => runApp(Shrine());

final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      accentColor: kShrineBrown900,
      primaryColor: kShrinePink100,
      buttonColor: kShrinePink100,
      scaffoldBackgroundColor: kShrineBackgroundWhite,
      cardColor: kShrineBackgroundWhite,
      textSelectionColor: kShrinePink100,
      errorColor: kShrineErrorRed,
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      accentTextTheme: _buildTextTheme(base.textTheme),
      inputDecorationTheme: InputDecorationTheme(border: CutCornersBorder()));
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
          headline: base.headline.copyWith(
            fontWeight: FontWeight.w500,
          ),
          title: base.title.copyWith(fontSize: 18.0),
          caption: base.caption.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ))
      .apply(
          fontFamily: 'Rubik',
          displayColor: kShrineBrown900,
          bodyColor: kShrineBrown900);
}

class Shrine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return MaterialApp(home: LoginPage(), theme: _kShrineTheme,);
    return MaterialApp(home: HomePage(), theme: _kShrineTheme,);
  }
}
