import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'package:drivn/features/auth/presentation/views/account.type.view.dart';
import 'package:drivn/features/auth/presentation/views/login_screen.dart';
import 'package:drivn/features/onboarding_screens/onboard.dart';
import '../../../../../shared/utils/shared.prefs.manager.dart';
import '../../../../driver/presentation/dependency.injection/bindings.dart';
import '../../providers/user.auth.provider.dart';

class AuthState extends StatefulWidget {
  const AuthState({Key? key}) : super(key: key);

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
    super.initState();
    accountType = context.read<UserAuthProvider>().accountType;
    Future.microtask(() async {
      await _hasAccess();
      _checkOnboardingStatus();
    });
  }

  @override
  void dispose() {
    // Dispose of resources here if necessary
    super.dispose();
  }

  Future<void> _hasAccess() async {
    user = await prefs.read(key: 'refreshToken');
    currentUser = _prefs.getString('userID', '');
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = SharedPreferencesManager.instance;
    bool onboardingShown = prefs.getBool('onboardingShown', false);

    if (onboardingShown) {
      if (accountType.isEmpty) {
        _navigateToReplacement(const AccountTypeView());
      }
    } else {
      prefs.setBool('onboardingShown', true);
      _navigateToReplacement(const OnbordingPage());
    }
  }

  void _navigateToReplacement(Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (user != null && (currentUser != null && currentUser!.isNotEmpty)) {
    //   return accountType == 'fleet-owner' ? const OMainPage() : const DMainPage();
    // } else {
    return const LoginView();
    // }
  }
}
