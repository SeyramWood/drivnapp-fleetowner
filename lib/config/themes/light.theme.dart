import 'package:flutter/material.dart';

import '../../utils/contants/colors.dart';

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
        ))
        // Add other theme configurations as needed.
        );
  }
}
