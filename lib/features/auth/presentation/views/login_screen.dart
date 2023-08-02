import 'package:drivn_app/features/auth/presentation/views/register_screen.dart';
import 'package:drivn_app/features/auth/presentation/widget/elevated.button.dart';
import 'package:flutter/material.dart';
import 'package:drivn_app/features/auth/presentation/views/request.password.reset.view.dart';

import '../../../../app/home.dart';
import '../../../../utils/constants/colors.dart';
import '../widget/formfield.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

  void signUserIn() {
    if (_formKey.currentState?.validate() ?? false) {
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
      backgroundColor: blue,
      appBar: AppBar(
        backgroundColor: blue,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 50),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                'Welcome back, you\'ve been missed!',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                ),
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
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestPinView(),
                        ),
                      );
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: yellow,
                          // fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 16),
                  CustomElevatedButton(
                    onPressed: () {},
                    child: Text('Login'),
                  ),
                  const SizedBox(height: 10),
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
    );
  }
}
