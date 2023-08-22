import 'package:drivn_app/features/auth/presentation/providers/auth.shared.provider.dart';
import 'package:drivn_app/features/auth/presentation/providers/fleet.owner.dart';
import 'package:drivn_app/features/auth/presentation/views/login_screen.dart';
import 'package:drivn_app/features/auth/presentation/widget/phone.field.dart';
import 'package:drivn_app/features/auth/presentation/widget/google.button.dart';
import 'package:drivn_app/features/user/domain/entities/fleetOwner.model.dart';
import 'package:drivn_app/shared/utils/constants/colors.dart';
import 'package:drivn_app/shared/utils/extentions/on.custom.elevated.button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../widget/elevated.button.dart';
import '../widget/formfield.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

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
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
        child: SafeArea(
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
                      controller: _firstNameController,
                      labelText: 'First Name',
                      prefixIcon: Icon(Icons.person_2_outlined),
                    ),
                    CustomFormField(
                      controller: _lastNameController,
                      labelText: 'Last Name',
                      prefixIcon: Icon(Icons.person_2_outlined),
                    ),
                    PhoneFormField(
                      controller: _phoneNumberController,
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
                      backgroundColor: black,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //fleetOwner object
                          final fleetOwner = FleetOwner(
                            lastName: _lastNameController.text,
                            firstName: _firstNameController.text,
                            username: context.read<AuthSharedProvider>().phone,
                            password: _passwordController.text,
                            confirmPassword: _repeatPasswordController.text,
                          );
                          //method to create a fleetowner account
                          context
                              .read<FleetOwnerProvider>()
                              .postFleetOwner(fleetOwner, context);
                        }
                      },
                      child: Text('Register'),
                    ).loading(false),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        PageTransition(
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 600),
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
                    SizedBox(
                      height: 10,
                    ),
                    GoogleButton(
                      onTap: () {
                        print(context.read<AuthSharedProvider>().phone);
                      },
                      title: 'Sign up',
                    )
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
