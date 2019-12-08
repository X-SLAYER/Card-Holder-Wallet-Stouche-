import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider({this.isLightTheme});

  ThemeData get getThemeData => isLightTheme ? lightTheme : darkTheme;

  set setThemeData(bool val) {
    if (val) {
      isLightTheme = true;
    } else {
      isLightTheme = false;
    }
    notifyListeners();
  }
}

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: Color(0xFF000000),
  accentColor: Colors.white,
  cardColor: Color.fromRGBO(28,28,28, 1),
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black54,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: Color(0xFFE5E5E5),
  cardColor: Colors.grey[100],
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);