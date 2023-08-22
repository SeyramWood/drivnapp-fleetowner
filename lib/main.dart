import 'package:drivn_app/config/themes/light.theme.dart';
import 'package:drivn_app/features/auth/presentation/providers/auth.shared.provider.dart';
import 'package:drivn_app/features/auth/presentation/views/register_screen.dart';
import 'package:drivn_app/features/car/presentations/providers/car.provider.dart';
import 'package:drivn_app/features/driver/presentation/views/main.page.dart';
import 'package:drivn_app/features/user/presentation/bindings/fleet.owner.bindings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth/presentation/views/account.type.view.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => CarProvider(),
    )
  ], child: const MyApp()));
}

FleetOwnerBindings bindings = FleetOwnerBindings();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthSharedProvider()),
        bindings.fleetOwnerAPI,
        bindings.fleetOwnerDB,
        bindings.fleetOwnerRepo,
        bindings.postFleetOwner,
        bindings.verifyFleetOwner,
        bindings.fleetOwnerProvider,
      ],
      child: MaterialApp(
        theme: AppLightTheme.themeData,
        home: RegisterView(),
      ),
    );
  }
}
