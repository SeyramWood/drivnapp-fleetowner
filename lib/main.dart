import 'package:drivn_app/app/home.dart';
import 'package:drivn_app/config/themes/light.theme.dart';
import 'package:drivn_app/features/car/presentations/providers/car.provider.dart';
import 'package:drivn_app/features/car/presentations/views/add.car.form.dart';
import 'package:drivn_app/features/car/presentations/views/car.detail.dart';
import 'package:drivn_app/features/driver/presentation/views/main.page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth/presentation/views/login_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => CarProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppLightTheme.themeData,
      home: DMainPage(),
    );
  }
}
