import 'package:drivn/features/auth/presentation/views/register_screen.dart';
import 'package:drivn/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn/features/auth/presentation/widget/formfield.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../../../shared/utils/validators.dart';
import 'otp.input.view.dart';

class RequestPinView extends StatefulWidget {
  const RequestPinView({super.key});

  @override
  _RequestPinViewState createState() => _RequestPinViewState();
}

class _RequestPinViewState extends State<RequestPinView> {
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

  void signUserIn() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with sign-in logic
      // You can access the entered values using _controllerUsername.text and _controllerPassword.text
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
      backgroundColor: blue,
      appBar: AppBar(
        title: const Text('Forgot Your Password?',
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
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 25),
            const Text(
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
                  CustomFormField(
                    controller: _controllerUsername,
                    labelText: 'Enter Address',
                    validator: (p0) => MyFormFieldValidator()
                        .nameValidate(_controllerUsername.text),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 2.3,
                  ),
                  CustomElevatedButton(
                    backgroundColor: black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OTPInputView(),
                        ),
                      );
                    },
                    child: const Text(
                      "Send Request",
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterView(key: widget.key)),
                        (route) => false),
                    child: RichText(
                      text: const TextSpan(
                        text: "Don't have an account?  ",
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
                            ),
                          )
                        ],
                      ),
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
