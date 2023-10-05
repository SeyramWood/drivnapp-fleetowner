// import 'dart:convert';

import 'package:drivn/features/auth/presentation/providers/auth.shared.provider.dart';
import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/auth/presentation/views/login_screen.dart';
import 'package:drivn/features/auth/presentation/widget/phone.field.dart';
import 'package:drivn/features/user/domain/entities/user.signup.model.dart';
import 'package:drivn/shared/errors/error.alert.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:drivn/shared/utils/extentions/on.custom.elevated.button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../shared/utils/validators.dart';
import '../widget/elevated.button.dart';
import '../widget/formfield.dart';
import 'otp.input.view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
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

  void clearControllers() {
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneNumberController.clear();
    _passwordController.clear();
    _repeatPasswordController.clear();
  }

  final _validator = MyFormFieldValidator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.cover,
                  height: 80,
                ),
                Center(
                  child: Text(
                    'Create account to get started!',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                const SizedBox(height: 25),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        validator: (p0) => _validator.nameValidate(p0),
                        controller: _firstNameController,
                        labelText: 'First name',
                        prefixIcon: const Icon(Icons.person_2_outlined),
                      ),
                      CustomFormField(
                        validator: (p0) => _validator.nameValidate(p0),
                        controller: _lastNameController,
                        labelText: 'Last name',
                        prefixIcon: const Icon(Icons.person_2_outlined),
                      ),
                      PhoneFormField(
                        controller: _phoneNumberController,
                      ),
                      CustomFormField(
                        obscureText: _obscurePassword,
                        validator: (p0) => _validator.passwordValidtor(p0),
                        controller: _passwordController,
                        labelText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () => togglePasswordVisibility(),
                          child: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      CustomFormField(
                        obscureText: _obscureRepeatPassword,
                        textInputAction: TextInputAction.done,
                        validator: (p0) => _validator.passwordValidtor(p0),
                        controller: _repeatPasswordController,
                        labelText: 'Repeat password',
                        suffixIcon: GestureDetector(
                          onTap: () => toggleRepeatPasswordVisibility(),
                          child: Icon(
                            _obscureRepeatPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .8,
                        child: CustomElevatedButton(
                          backgroundColor: black,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              LoadingDialog.showLoadingDialog(context);
                              //fleetOwner object
                              final signUpBody = SignUpBody(
                                lastName: _lastNameController.text.trim(),
                                firstName: _firstNameController.text.trim(),
                                username: context
                                    .read<AuthSharedProvider>()
                                    .phone
                                    .trim(),
                                password: _passwordController.text.trim(),
                                confirmPassword:
                                    _repeatPasswordController.text.trim(),
                              );
                              //method to create a fleetowner account

                              await context
                                  .read<UserAuthProvider>()
                                  .postUser(
                                      signUpBody,
                                      context
                                          .read<UserAuthProvider>()
                                          .accountType)
                                  .then(
                                (failure) {
                                  if (failure != null) {
                                    LoadingDialog.hideLoadingDialog(context);

                                    showErrorDialogue(
                                      context,
                                      failure,
                                    );
                                  } else if (failure == null) {
                                    // clearControllers();
                                    LoadingDialog.hideLoadingDialog(context);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => OTPInputView(
                                        phoneNumber: context
                                            .read<AuthSharedProvider>()
                                            .phone
                                            .trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      ),
                                    ));
                                  }
                                },
                              );
                            }
                          },
                          child: const Text('Sign up'),
                        ).loading(
                          context.watch<UserAuthProvider>().isLoading,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                                      color: white,
                                    ),
                            children: const [
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  color: yellow,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
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
