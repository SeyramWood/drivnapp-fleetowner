import 'package:flutter/material.dart';

import '../../shared/utils/constants/colors.dart';

class AppLightTheme {
  static ThemeData get themeData {
    return ThemeData(
      // primaryColor: blue,
      colorScheme: ColorScheme.fromSeed(seedColor: blue),
      useMaterial3: true,
      // scaffoldBackgroundColor: white,
      appBarTheme: AppBarTheme(
        color: white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          backgroundColor: MaterialStateProperty.all(blue),
          foregroundColor: MaterialStateProperty.all(white),
        ),
      ),
      textTheme: TextTheme(
          headlineLarge: TextStyle(
              color: white, fontFamily: 'Inter', fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(fontSize: 22),
          headlineSmall:
              TextStyle(color: white, fontFamily: 'Inter', fontSize: 18),
          bodyLarge: TextStyle(fontFamily: 'Inter')),
    );
  }
}
