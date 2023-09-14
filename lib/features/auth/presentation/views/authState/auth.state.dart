import 'package:drivn/features/auth/presentation/views/login_screen.dart';
import 'package:drivn/features/driver/presentation/views/main.page.dart';
import 'package:drivn/features/onboarding_screens/onboard.dart';
import 'package:drivn/features/owner/presentations/views/home.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState extends StatefulWidget {
  const AuthState({super.key});

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  String? user;
  late bool userIsOwner;

  initUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    user = prefs.getString('userID');
  }

  @override
  void initState() {
    userIsOwner = context.read<APIService>().accTypeIsOwner;
    initUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return userIsOwner ? const OMainPage() : const DMainPage();
    } else if (user == null) {
      return const LoginView();
    }
    return const OnbordingPage();
  }
}
