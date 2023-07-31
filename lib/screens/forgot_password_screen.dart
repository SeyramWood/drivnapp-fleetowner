
import 'package:drivn_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:drivn_app/components/user_inputs/username_input_validator.dart';

import '../components/user_inputs/email_input_decoration.dart';
import 'enter_otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

  void signUserIn() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with sign-in logic
      // You can access the entered values using _controllerUsername.text and _controllerPassword.text
      print('Signing in...');
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Don't worry! It occurs. Please enter the email address linked with your account.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
                      decoration: getEmailInputDecoration(),
                      onEditingComplete: () =>
                          _focusNodePassword.requestFocus(),
                      style: TextStyle(color: Colors.white),
                      validator: UsernameInputValidator.validate,
                    ),
                    const SizedBox(height: 32),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              color:  Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OTPScreen()));
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  "Send Code",
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
