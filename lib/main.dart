import 'package:drivn/config/themes/light.theme.dart';
import 'package:drivn/features/auth/presentation/providers/auth.shared.provider.dart';
import 'package:drivn/features/auth/presentation/views/authState/auth.state.dart';
import 'package:drivn/features/driver/presentation/dependency.injection/bindings.dart';
import 'package:drivn/features/driver/presentation/provider/toggle.dart';
import 'package:drivn/features/owner/presentations/providers/available.or.booked.dart';
import 'package:drivn/features/user/presentation/bindings/fleet.owner.bindings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/onboarding_screens/onboard.dart';

void main() {
  setupDriverDependencies();
  runApp(const MyApp());
}

UserBindings bindings = UserBindings();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarProvider()),
        ChangeNotifierProvider(create: (context) => AuthSharedProvider()),
        ChangeNotifierProvider(create: (context) => driverImplProvider),
        bindings.apiService,
        bindings.userRepo,
        bindings.postUser,
        bindings.verifUser,
        bindings.submitID,
        bindings.userAuthProvider,
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppLightTheme.themeData,
        home: const OnbordingPage(),
        // home: const DriverDocsView(),
      ),
    );
  }
}
