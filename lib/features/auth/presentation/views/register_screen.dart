import 'package:drivn_app/features/auth/presentation/views/login_screen.dart';
import 'package:drivn_app/features/auth/presentation/widget/country.picker.dart';
import 'package:drivn_app/features/auth/presentation/widget/google.button.dart';
import 'package:drivn_app/utils/constants/colors.dart';
import 'package:drivn_app/utils/extentions/on.elevated.button.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import '../widget/elevated.button.dart';
import '../widget/formfield.dart';
import 'otp.input.view.dart';

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

  final countryPicker = const FlCountryCodePicker();
  CountryCode? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF554AF0),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
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
                    labelText: 'First Name',
                    prefixIcon: Icon(Icons.person_2_outlined),
                  ),
                  CustomFormField(
                    controller: _nameController,
                    labelText: 'Last Name',
                    prefixIcon: Icon(Icons.person_2_outlined),
                  ),
                  CodePickerField(
                    controller: _emailController,
                  ),
                  CustomFormField(
                    controller: _passwordController,
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.password_outlined),
                    suffixIcon: Icons.visibility,
                  ),
                  CustomFormField(
                    controller: _repeatPasswordController,
                    labelText: 'Repeat password',
                    prefixIcon: Icon(Icons.password_outlined),
                    suffixIcon: Icons.visibility,
                  ),
                  // const SizedBox(height: 10),
                  CustomElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OTPInputView(),
                      ),
                    ),
                    child: Text('Register'),
                  ).loading(false),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => LoginView(key: widget.key)),
                      (route) => false,
                    ),
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
                            text: 'Login',
                            style: TextStyle(
                              color: yellow,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GoogleButton(
                    onTap: () {},
                    title: 'Sign up',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//this widget is responsible for picking country codes
  Widget countryCodePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Show the country code picker when tapped.
        final cCode = await countryPicker.showPicker(context: context);
        // Null check
        if (cCode != null) {
          code = cCode;
          print(code!.code);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 6.0,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: const BoxDecoration(
            color: yellow,
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child:
            Text('country code', style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
