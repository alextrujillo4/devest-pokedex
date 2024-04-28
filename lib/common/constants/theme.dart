import 'package:flutter/material.dart';

ThemeData appTheme(Color primaryColor) => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(primary: primaryColor, seedColor: primaryColor),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'PokemonSolid',
      fontSize: 40,
    ),
    titleMedium: TextStyle(
      fontSize: 24,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
    ),
  ),
);
