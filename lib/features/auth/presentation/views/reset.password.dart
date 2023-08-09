import 'package:drivn_app/features/auth/presentation/views/login_screen.dart';
import 'package:drivn_app/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn_app/features/auth/presentation/widget/formfield.dart';
import 'package:drivn_app/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:drivn_app/components/user_inputs/username_input_validator.dart';


class ResetPasswordView extends StatefulWidget {
  ResetPasswordView({Key? key}) : super(key: key);

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

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
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      appBar: AppBar(
        title: Text('Change Password',
            style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: blue,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 50),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 25),
            Text(
              "Enter a password not easy to guess. Must not be less than 8 characters.",
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
                  CustomFormField(
                    controller: _passwordController,
                    labelText: 'Enter Password',
                    validator: UsernameInputValidator.validate,
                  ),
                  CustomFormField(
                    controller: _passwordController,
                    labelText: 'Repeat Password',
                    validator: UsernameInputValidator.validate,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password changed successful'),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginView(),
                        ),
                      );
                    },
                    child: Text(
                      "Change Password",
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
