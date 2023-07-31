// import 'package:flutter/material.dart';
import 'package:drivn_app/features/auth/presentation/views/register_screen.dart';
import 'package:flutter/material.dart';

// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: RegisterView(),
    );
  }
}
