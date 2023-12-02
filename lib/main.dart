import 'package:drivn/config/themes/light.theme.dart';
import 'package:drivn/features/auth/presentation/providers/auth.shared.provider.dart';
import 'package:drivn/features/auth/presentation/views/authState/auth.state.dart';
import 'package:drivn/features/driver/presentation/dependency.injection/bindings.dart';
import 'package:drivn/features/owner/presentations/providers/available.or.booked.dart';
import 'package:drivn/features/user/presentation/dependency/user.dependency.injection.dart';
import 'package:drivn/shared/interceptor/http.client.interceptor.dart';
import 'package:drivn/shared/utils/shared.prefs.manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/owner/presentations/dependency/owner.dependency.injection.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await SharedPreferencesManager.instance.init();
  } catch (e) {
    // Handle initialization error (e.g., log the error, display an error message)
    print('Error initializing SharedPreferences: $e');
  }
  setupDriverDependencies();
  setupOwnerDependencies();
  //auth dependency locator
  setupUserDependencies();
  setStorageLocator();
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
        ChangeNotifierProvider(create: (context) => driverImplProvider),
        ChangeNotifierProvider(create: (context) => userAuthProvider),
        ChangeNotifierProvider(create: (context) => ownerImplProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppLightTheme.themeData,
        home: const AuthState(),
        // home: const DriverDocsView(),
      ),
    );
  }
}
// keytool -list -v -keystore c/Users/kojomensah.android\debug.keystore -alias androiddebugkey

// keytool -list -v -keystore ~/Users/kojomensah/.android/debug.keystore -alias androiddebugkey

// keytool -exportcert -alias androiddebugkey -keystore "C:\Users\kojomensah\.android\debug.keystore" -list -v

// keytool -list -v -keystore C:\Users\kojomensah\.android\debug.keystore -alias androiddebugkey

// -keystore C:\Users\kojomensah\.android\debug.keystore -alias androiddebugkey





//ios client id //707888038435-h1jtdkqat3punrqqpcv39vbltr9ai2rj.apps.googleusercontent.com

//android client id //707888038435-9vuvrq33uammvdvjq62fa8jk7bjc5bh5.apps.googleusercontent.com