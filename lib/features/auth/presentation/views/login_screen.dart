import 'package:drivn_app/features/auth/presentation/views/register_screen.dart';
import 'package:drivn_app/features/auth/presentation/widget/phone.field.dart';
import 'package:drivn_app/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn_app/features/auth/presentation/widget/google.button.dart';
import 'package:flutter/material.dart';
import 'package:drivn_app/features/auth/presentation/views/request.password.reset.view.dart';

import '../../../../app/home.dart';
import '../../../../shared/utils/constants/colors.dart';
import '../widget/formfield.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _phoneController = TextEditingController();
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
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
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
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: white,
                    ),
              ),
            ),
            const SizedBox(height: 25),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  PhoneFormField(
                    controller: _phoneController,
                  ),
                  CustomFormField(
                    controller: _passwordController,
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.password_outlined),
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
                    backgroundColor: black,
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false,
                      );
                    },
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                        children: [
                          TextSpan(
                            text: 'Register.',
                            style: TextStyle(
                              color: yellow,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GoogleButton(
                    onTap: () {},
                    title: 'Login',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
