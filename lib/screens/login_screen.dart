import 'package:drivn_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:drivn_app/components/user_inputs/password_input_decoration.dart';
import 'package:drivn_app/components/user_inputs/username_input_decoration.dart';
import 'package:drivn_app/screens/forgot_password_screen.dart';
import 'package:drivn_app/components/login_button.dart';
import 'package:drivn_app/components/user_inputs/username_input_validator.dart';
import 'package:drivn_app/components/user_inputs/password_input_validator.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

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
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
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
              const SizedBox(height: 50),
              const Icon(
                Icons.lock,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 50),
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
                    TextFormField(
                      controller: _controllerUsername,
                      keyboardType: TextInputType.name,
                      decoration: getUsernameInputDecoration(),
                      onEditingComplete: () =>
                          _focusNodePassword.requestFocus(),
                      style: TextStyle(color: Colors.white),
                      validator: UsernameInputValidator.validate,
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _controllerPassword,
                      focusNode: _focusNodePassword,
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: getPasswordInputDecoration(
                          _obscurePassword, togglePasswordVisibility),
                      style: TextStyle(color: Colors.white),
                      validator: PasswordInputValidator.validate,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account? ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
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
