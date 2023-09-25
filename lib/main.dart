import 'package:drivn/config/themes/light.theme.dart';
import 'package:drivn/features/auth/presentation/providers/auth.shared.provider.dart';
import 'package:drivn/features/driver/presentation/dependency.injection/bindings.dart';
import 'package:drivn/features/owner/presentations/providers/available.or.booked.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:drivn/features/user/presentation/bindings/fleet.owner.bindings.dart';
import 'package:drivn/shared/utils/shared.prefs.manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/onboarding_screens/onboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesManager.instance.init();
  setupDriverDependencies();
  //auth dependency locator
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarProvider()),
        ChangeNotifierProvider(create: (context) => AuthSharedProvider()),
        ChangeNotifierProvider(create: (context) => APIService()),
        ChangeNotifierProvider(create: (context) => driverImplProvider),
        ChangeNotifierProvider(create: (context) => userAuthProvider),
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
