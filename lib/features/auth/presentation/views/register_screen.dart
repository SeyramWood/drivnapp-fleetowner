// import 'dart:convert';

import 'package:drivn/features/auth/presentation/providers/auth.shared.provider.dart';
import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/auth/presentation/views/login_screen.dart';
import 'package:drivn/features/auth/presentation/widget/phone.field.dart';
import 'package:drivn/features/auth/presentation/widget/google.button.dart';
import 'package:drivn/features/user/domain/entities/user.signup.model.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:drivn/shared/utils/extentions/on.custom.elevated.button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../shared/utils/validators.dart';
import '../widget/elevated.button.dart';
import '../widget/formfield.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  final _validator = MyFormFieldValidator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        validator: (p0) => _validator.nameValidate(p0),
                        controller: _firstNameController,
                        labelText: 'First Name',
                        prefixIcon: const Icon(Icons.person_2_outlined),
                      ),
                      CustomFormField(
                        validator: (p0) => _validator.nameValidate(p0),
                        controller: _lastNameController,
                        labelText: 'Last Name',
                        prefixIcon: const Icon(Icons.person_2_outlined),
                      ),
                      PhoneFormField(
                        controller: _phoneNumberController,
                      ),
                      CustomFormField(
                        validator: (p0) => _validator.passwordValidtor(p0),
                        controller: _passwordController,
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.password_outlined),
                        suffixIcon: Icons.visibility,
                      ),
                      CustomFormField(
                        validator: (p0) => _validator.passwordValidtor(p0),
                        controller: _repeatPasswordController,
                        labelText: 'Repeat password',
                        prefixIcon: const Icon(Icons.password_outlined),
                        suffixIcon: Icons.visibility,
                      ),
                      // const SizedBox(height: 10),
                      CustomElevatedButton(
                        backgroundColor: black,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //fleetOwner object
                            final fleetOwner = SignUpBody(
                              lastName: _lastNameController.text,
                              firstName: _firstNameController.text,
                              username:
                                  context.read<AuthSharedProvider>().phone,
                              password: _passwordController.text,
                              confirmPassword: _repeatPasswordController.text,
                            );
                            if (_phoneNumberController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Phone number required'),
                              ));
                            }
                            //method to create a fleetowner account
                            else {
                              context
                                  .read<UserAuthProvider>()
                                  .postUser(fleetOwner, context);
                            }
                          }
                        },
                        child: const Text('Register'),
                      ).loading(false),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushAndRemoveUntil(
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 600),
                              child: LoginView(key: widget.key)),
                          (route) => false,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                            children: const [
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
                      const SizedBox(
                        height: 10,
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
        ),
      ),
    );
  }
}

// void main() async {
//   final url = Uri.parse('https://devapi.drivnapp.net/api/fleet-owners');
//   http.Response? response;
//   try {
//     response = await http.get(
//       url,
//       // headers: {'content-type': 'application/json'},
//       // body: jsonEncode(fleetOwner)
//     );
//     if (response.statusCode == 200) {
//       print('success made');
//     } else {
//       print('${response.reasonPhrase}');
//     }
//   } on Exception catch (e) {
//     log(e.toString());
//   }
// }
