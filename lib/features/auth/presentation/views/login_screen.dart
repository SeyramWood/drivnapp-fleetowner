import 'package:drivn_app/features/auth/presentation/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:drivn_app/features/auth/presentation/views/forgot_password_screen.dart';
import 'package:drivn_app/components/login_button.dart';

import '../../../../app/home.dart';
import '../../../../utils/contants/colors.dart';
import '../widget/formfield.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

  // void signUserIn() {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     // Form is valid, proceed with sign-in logic
  //     // You can access the entered values using _controllerUsername.text and _controllerPassword.text
  //     print('Signing in...');
  //   }
  // }

  void signUserIn() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with sign-in logic
      // You can access the entered values using _controllerUsername.text and _controllerPassword.text
      print('Signing in...');

      // Navigate to the home screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF554AF0),
      appBar: AppBar(
        backgroundColor: Color(0xFF554AF0),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'Welcome back, you\'ve been missed!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormField(
                      controller: _emailController,
                      labelText: 'Email',
                      prefixIcon: Icons.email_outlined,
                    ),
                    CustomFormField(
                      controller: _passwordController,
                      labelText: 'Password',
                      prefixIcon: Icons.password_outlined,
                      suffixIcon: Icons.visibility,
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: LoginButton(onTap: signUserIn),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegisterView(key: widget.key)),
                          (route) => false),
                      child: RichText(
                        text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                  text: 'Register.',
                                  style: TextStyle(
                                    color: yellow,
                                    fontWeight: FontWeight.w700,
                                  ))
                            ]),
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
