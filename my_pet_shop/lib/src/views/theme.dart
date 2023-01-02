import 'package:flutter/material.dart';

ThemeData _themeLight = ThemeData.light();

final Color? _pink = Colors.pink[100];
final Color _green = Colors.lightGreenAccent.shade100;

ThemeData themeLight = _themeLight.copyWith(
    appBarTheme: AppBarTheme(
        color: _green,
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.pink, fontSize: 18, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.pink)),
    primaryTextTheme: _textLight(_themeLight.textTheme),
    textTheme: _textLight(_themeLight.textTheme),
    primaryColor: _green,
    primaryColorLight: _green,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
      primary: Colors.pink,
      backgroundColor: _green,
    )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _pink,
        selectedLabelStyle: TextStyle(color: _green),
        selectedItemColor: _green),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: _green),
        focusColor: _green,
        suffixIconColor: _pink,
        iconColor: _pink),
    cardColor: _green,
    chipTheme: ChipThemeData(backgroundColor: _pink, selectedColor: _green),
    scaffoldBackgroundColor: _pink,
    dialogBackgroundColor: _pink);

TextTheme _textLight(TextTheme base) {
  return base.copyWith(
    headline2:
        TextStyle(color: _green, fontSize: 15, fontWeight: FontWeight.bold),
    bodyText2: const TextStyle(
        color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
  );
}
