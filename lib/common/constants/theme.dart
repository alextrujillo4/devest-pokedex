import 'package:flutter/material.dart';

ThemeData appTheme(Color primaryColor) => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(primary: primaryColor, seedColor: primaryColor),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Corben',
      fontWeight: FontWeight.w700,
      fontSize: 24,
      color: Colors.black,
    ),
  ),
);
