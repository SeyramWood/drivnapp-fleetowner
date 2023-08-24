import 'package:drivn/features/auth/presentation/views/login_screen.dart';
import 'package:drivn/features/auth/presentation/views/register_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF554AF0),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 25),
              //login button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  // vertical: 5,
                ),
                child: Expanded(
                  child: MaterialButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const LoginView()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              //register button

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  // vertical: 5,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 350,
                      height: 56,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.white, width: 1.5),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
