import 'package:flutter/material.dart';

const TextStyle headlineLarge = TextStyle(fontSize: 22, color: Colors.red);
const TextStyle titleMedium = TextStyle(fontSize: 18);
const TextStyle bodyMedium = TextStyle(fontSize: 14);
const TextStyle bodySmall = TextStyle(fontSize: 12);

final lightTheme = ThemeData(
  // brightness: darkMode ? Brightness.dark : Brightness.light,
  textTheme: const TextTheme(
    titleMedium: titleMedium,
    bodySmall: bodySmall,
    headlineLarge: headlineLarge,
  ),
  primarySwatch: Colors.red,
);
