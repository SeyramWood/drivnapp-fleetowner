import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class AppLightTheme {
  static ThemeData get themeData {
    return ThemeData(
        // primaryColor: blue,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.blue,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            backgroundColor: MaterialStateProperty.all(black),
            foregroundColor: MaterialStateProperty.all(white),
          ),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(color: white),
          headlineSmall: TextStyle(color: white, fontSize: 18),
        ));
  }
}
