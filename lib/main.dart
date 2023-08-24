import 'package:drivn/config/themes/light.theme.dart';
import 'package:drivn/features/auth/presentation/providers/auth.shared.provider.dart';
import 'package:drivn/features/car/presentations/providers/car.provider.dart';
import 'package:drivn/features/user/presentation/bindings/fleet.owner.bindings.dart';
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

UserBindings bindings = UserBindings();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthSharedProvider()),
        bindings.apiService,
        bindings.userDB,
        bindings.userRepo,
        bindings.postUser,
        bindings.verifUser,
        bindings.submitID,
        bindings.userAuthProvider,
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppLightTheme.themeData,
        home: const AccountTypeView(),
      ),
    );
  }
}
