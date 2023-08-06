import 'package:drivn_app/config/themes/light.theme.dart';
import 'package:drivn_app/features/cars/presentations/views/car.detail.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppLightTheme.themeData,
      home: CarDetails(),
    );
  }
}
