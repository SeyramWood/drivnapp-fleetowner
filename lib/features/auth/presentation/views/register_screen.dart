import 'package:drivn_app/features/auth/presentation/views/login_screen.dart';
import 'package:drivn_app/utils/contants/colors.dart';
import 'package:flutter/material.dart';
import '../widget/formfield.dart';
import 'otp_screen.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureRepeatPassword = true;

  final _formKey = GlobalKey<FormState>();
  bool _isRegistering = false;

  void registerUser(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isRegistering = true;
      });

      // Simulate an asynchronous registration process
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isRegistering = false;
        });

        // Navigate to the OTP screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPInputView(),
          ),
        );
      });
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void toggleRepeatPasswordVisibility() {
    setState(() {
      _obscureRepeatPassword = !_obscureRepeatPassword;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF554AF0),
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
                'Create account to get started!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomFormField(
                      controller: _nameController,
                      labelText: 'Full Name',
                      prefixIcon: Icons.person_2_outlined),
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
                  CustomFormField(
                    controller: _repeatPasswordController,
                    labelText: 'Repeat password',
                    prefixIcon: Icons.password_outlined,
                    suffixIcon: Icons.visibility,
                  ),
                  // const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Register'),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                        backgroundColor: MaterialStateProperty.all(black),
                        foregroundColor: MaterialStateProperty.all(white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => LoginScreen(key: widget.key)),
                        (route) => false),
                    child: RichText(
                      text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                                text: 'Login.',
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
