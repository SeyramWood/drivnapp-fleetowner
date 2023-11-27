import 'package:drivn/features/auth/presentation/views/account.type.view.dart';
import 'package:drivn/features/auth/presentation/views/login_screen.dart';
import 'package:drivn/features/driver/presentation/views/main.page.dart';
import 'package:drivn/features/onboarding_screens/onboard.dart';
import 'package:drivn/features/owner/presentations/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/utils/shared.prefs.manager.dart';
import '../../../../driver/presentation/dependency.injection/bindings.dart';
import '../../providers/user.auth.provider.dart';

class AuthState extends StatefulWidget {
  const AuthState({super.key});

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  String? user;
  String? currentUser;
  late String accountType;
  final prefs = getIt<FlutterSecureStorage>();
  final _prefs = SharedPreferencesManager.instance;

  @override
  void initState() {
    accountType = context.read<UserAuthProvider>().accountType;
    hasAccess();
    Future.microtask(() => checkOnboardingStatus());
    super.initState();
  }

  hasAccess() async {
    user = await prefs.read(key: 'refreshToken');
    currentUser = _prefs.getString('userID', '');
  }

  checkOnboardingStatus() async {
    final prefs = SharedPreferencesManager.instance;
    bool onboardingShown = prefs.getBool('onboardingShown', false);

    if (onboardingShown) {
      if (accountType.isEmpty) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AccountTypeView()));
      }
    } else {
      prefs.setBool('onboardingShown', true);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnbordingPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user != null && (currentUser != null || currentUser!.isNotEmpty)) {
      return accountType == 'fleet-owner'
          ? const OMainPage()
          : const DMainPage();
    } else {
      return const LoginView();
    }
  }
}
