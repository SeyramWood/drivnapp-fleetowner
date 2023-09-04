import 'package:drivn/features/auth/presentation/views/register_screen.dart';
import 'package:drivn/features/auth/presentation/widget/phone.field.dart';
import 'package:drivn/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn/features/driver/presentation/views/main.page.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:drivn/shared/utils/extentions/on.custom.elevated.button.dart';
import 'package:flutter/material.dart';
import 'package:drivn/features/auth/presentation/views/request.password.reset.view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../owner/presentations/views/home.dart';
import '../../../../shared/utils/constants/colors.dart';
import '../widget/formfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
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
        MaterialPageRoute(builder: (context) => const OMainPage()),
      );
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
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
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: GestureDetector(
                      onTap: () => togglePasswordVisibility(),
                      child: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print(Provider.of<APIService>(context, listen: false)
                          .accTypeIsOwner);

                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 400),
                          child: const RequestPinView(),
                        ),
                      );
                    },
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: yellow,
                          // fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    backgroundColor: black,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      Provider.of<APIService>(context, listen: false)
                          .logIn('51539607562')
                          .then(
                        (value) async {
                          await Future.delayed(const Duration(seconds: 2), () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      context.read<APIService>().accTypeIsOwner
                                          ? const OMainPage()
                                          : const DMainPage()),
                              (route) => false,
                            );
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                      );
                    },
                    child: const Text('Login'),
                  ).loading(isLoading),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterView(key: widget.key)),
                        (route) => false),
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account?",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: white,
                            ),
                        children: const [
                          TextSpan(
                            text: ' Register.',
                            style: TextStyle(
                              color: yellow,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
