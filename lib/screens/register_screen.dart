// import 'package:drivn_app/components/register_button.dart';
// import 'package:drivn_app/screens/login_screen.dart';
// import 'package:drivn_app/screens/otp_screen.dart';
// import 'package:flutter/material.dart';

// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF554AF0),
//       appBar: AppBar(
//         backgroundColor: Color(0xFF554AF0),
//         elevation: 0,
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//               ),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 child: const Text(
//                   "Hello! Register to get started",
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),

            
//             //username
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF7F8F9),
//                   border: Border.all(
//                     color: const Color(0xFFE8ECF4),
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     left: 10,
//                     right: 10,
//                   ),
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Username',
//                       hintStyle: TextStyle(
//                         color: Color(0xFF8391A1),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             //email
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF7F8F9),
//                   border: Border.all(
//                     color: const Color(0xFFE8ECF4),
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     left: 10,
//                     right: 10,
//                   ),
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Email',
//                       hintStyle: TextStyle(
//                         color: Color(0xFF8391A1),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             //password
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF7F8F9),
//                   border: Border.all(
//                     color: const Color(0xFFE8ECF4),
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     left: 10,
//                     right: 10,
//                   ),
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Password',
//                       hintStyle: TextStyle(
//                         color: Color(0xFF8391A1),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             //confirm password
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF7F8F9),
//                   border: Border.all(
//                     color: const Color(0xFFE8ECF4),
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     left: 10,
//                     right: 10,
//                   ),
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Confirm password',
//                       hintStyle: TextStyle(
//                         color: Color(0xFF8391A1),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 25),
//             //register button
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 5,
//               ),
//               child: RegisterButton(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => OtpScreen()),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 20),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Already have an account?  ",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LoginScreen(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     "Login",
//                     style: TextStyle(
//                       color: Color(0xFF35C2C1),
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





// import 'package:drivn_app/components/user_inputs/username_input_decoration.dart';
// import 'package:flutter/material.dart';


// import 'package:drivn_app/screens/login_screen.dart';

// import '../components/register_button.dart';
// import '../components/user_inputs/email_input_decoration.dart';
// import '../components/user_inputs/email_input_validator.dart';
// import '../components/user_inputs/password_input_decoration.dart';
// import '../components/user_inputs/password_input_validator.dart';
// import '../components/user_inputs/username_input_validator.dart';
// // Other imports...

// class RegisterScreen extends StatefulWidget {
//   RegisterScreen({Key? key}) : super(key: key);

//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final FocusNode _focusNodePassword = FocusNode();
//   final TextEditingController _controllerUsername = TextEditingController();
//   final TextEditingController _controllerEmail = TextEditingController();
//   final TextEditingController _controllerPassword = TextEditingController();

//   bool _obscurePassword = true;

//   final _formKey = GlobalKey<FormState>();

//   void registerUser() {
//     if (_formKey.currentState?.validate() ?? false) {
//       // Form is valid, proceed with registration logic
//       // You can access the entered values using _controllerUsername.text, _controllerEmail.text, and _controllerPassword.text
//       print('Registering user...');
//     }
//   }

//   void togglePasswordVisibility() {
//     setState(() {
//       _obscurePassword = !_obscurePassword;
//     });
//   }

//   @override
//   void dispose() {
//     _focusNodePassword.dispose();
//     _controllerUsername.dispose();
//     _controllerEmail.dispose();
//     _controllerPassword.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF554AF0),
//       appBar: AppBar(
//         backgroundColor: Color(0xFF554AF0),
//         elevation: 0,
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 50),
//               const Icon(
//                 Icons.app_registration,
//                 size: 100,
//                 color: Colors.white,
//               ),
//               const SizedBox(height: 50),
//               Text(
//                 'Create an account to get started!',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                 ),
//               ),
//               const SizedBox(height: 25),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _controllerUsername,
//                       keyboardType: TextInputType.name,
//                       decoration: getUsernameInputDecoration(),
//                       onEditingComplete: () =>
//                           _focusNodePassword.requestFocus(),
//                       style: TextStyle(color: Colors.white),
//                       validator: UsernameInputValidator.validate,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _controllerEmail,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: getEmailInputDecoration(),
//                       onEditingComplete: () =>
//                           _focusNodePassword.requestFocus(),
//                       style: TextStyle(color: Colors.white),
//                       validator: EmailInputValidator.validate,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _controllerPassword,
//                       focusNode: _focusNodePassword,
//                       obscureText: _obscurePassword,
//                       keyboardType: TextInputType.visiblePassword,
//                       decoration: getPasswordInputDecoration(
//                           _obscurePassword, togglePasswordVisibility),
//                       style: TextStyle(color: Colors.white),
//                       validator: PasswordInputValidator.validate,
//                     ),
//                     const SizedBox(height: 24),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                       child: RegisterButton(onTap: registerUser),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Already have an account? ",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>  LoginScreen(),
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             "Login",
//                             style: TextStyle(
//                               color: Colors.orange,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import '../components/register_button.dart';
// import '../components/user_inputs/email_input_decoration.dart';
// import '../components/user_inputs/email_input_validator.dart';
// import '../components/user_inputs/password_input_decoration.dart';
// import '../components/user_inputs/password_input_validator.dart';
// import '../components/user_inputs/username_input_decoration.dart';
// import '../components/user_inputs/username_input_validator.dart';

// import 'login_screen.dart';
// import 'otp_screen.dart';

// class RegisterScreen extends StatefulWidget {
//   RegisterScreen({Key? key}) : super(key: key);

//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final FocusNode _focusNodePassword = FocusNode();
//   final TextEditingController _controllerUsername = TextEditingController();
//   final TextEditingController _controllerEmail = TextEditingController();
//   final TextEditingController _controllerPassword = TextEditingController();

//   bool _obscurePassword = true;

//   final _formKey = GlobalKey<FormState>();
//   bool _isRegistering = false;

//   void registerUser(BuildContext context) {
//     if (_formKey.currentState?.validate() ?? false) {
//       setState(() {
//         _isRegistering = true;
//       });

//       // Simulate an asynchronous registration process
//       Future.delayed(Duration(seconds: 5), () {
//         setState(() {
//           _isRegistering = false;
//         });

//         // Navigate to the OTP screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OtpScreen(),
//           ),
//         );
//       });
//     }
//   }

//   void togglePasswordVisibility() {
//     setState(() {
//       _obscurePassword = !_obscurePassword;
//     });
//   }

//   @override
//   void dispose() {
//     _focusNodePassword.dispose();
//     _controllerUsername.dispose();
//     _controllerEmail.dispose();
//     _controllerPassword.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF554AF0),
//       appBar: AppBar(
//         backgroundColor: Color(0xFF554AF0),
//         elevation: 0,
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 50),
//               const Icon(
//                 Icons.app_registration,
//                 size: 100,
//                 color: Colors.white,
//               ),
//               const SizedBox(height: 50),
//               Text(
//                 'Create an account to get started!',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                 ),
//               ),
//               const SizedBox(height: 25),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _controllerUsername,
//                       keyboardType: TextInputType.name,
//                       decoration: getUsernameInputDecoration(),
//                       onEditingComplete: () =>
//                           _focusNodePassword.requestFocus(),
//                       style: TextStyle(color: Colors.white),
//                       validator: UsernameInputValidator.validate,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _controllerEmail,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: getEmailInputDecoration(),
//                       onEditingComplete: () =>
//                           _focusNodePassword.requestFocus(),
//                       style: TextStyle(color: Colors.white),
//                       validator: EmailInputValidator.validate,
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _controllerPassword,
//                       focusNode: _focusNodePassword,
//                       obscureText: _obscurePassword,
//                       keyboardType: TextInputType.visiblePassword,
//                       decoration: getPasswordInputDecoration(
//                           _obscurePassword, togglePasswordVisibility),
//                       style: TextStyle(color: Colors.white),
//                       validator: PasswordInputValidator.validate,
//                     ),
//                     const SizedBox(height: 24),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                       child: RegisterButton(
//                         onTap: _isRegistering
//                             ? null
//                             : () => registerUser(context),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Already have an account? ",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => LoginScreen(),
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             "Login",
//                             style: TextStyle(
//                               color: Colors.orange,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import '../components/register_button.dart';
// import '../components/user_inputs/email_input_decoration.dart';
// import '../components/user_inputs/email_input_validator.dart';
// import '../components/user_inputs/password_input_decoration.dart';
// import '../components/user_inputs/password_input_validator.dart';
// import '../components/user_inputs/username_input_decoration.dart';
// import '../components/user_inputs/username_input_validator.dart';

// import 'login_screen.dart';
// import 'otp_screen.dart';

// class RegisterScreen extends StatefulWidget {
//   RegisterScreen({Key? key}) : super(key: key);

//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final FocusNode _focusNodePassword = FocusNode();
//   final TextEditingController _controllerUsername = TextEditingController();
//   final TextEditingController _controllerEmail = TextEditingController();
//   final TextEditingController _controllerPassword = TextEditingController();

//   bool _obscurePassword = true;

//   final _formKey = GlobalKey<FormState>();
//   bool _isRegistering = false;

//   void registerUser(BuildContext context) {
//     if (_formKey.currentState?.validate() ?? false) {
//       setState(() {
//         _isRegistering = true;
//       });

//       // Simulate an asynchronous registration process
//       Future.delayed(Duration(seconds: 2), () {
//         setState(() {
//           _isRegistering = false;
//         });

//         // Navigate to the OTP screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OtpScreen(),
//           ),
//         );
//       });
//     }
//   }

//   void togglePasswordVisibility() {
//     setState(() {
//       _obscurePassword = !_obscurePassword;
//     });
//   }

//   @override
//   void dispose() {
//     _focusNodePassword.dispose();
//     _controllerUsername.dispose();
//     _controllerEmail.dispose();
//     _controllerPassword.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF554AF0),
//       appBar: AppBar(
//         backgroundColor: Color(0xFF554AF0),
//         elevation: 0,
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               padding: const EdgeInsets.all(30.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 50),
//                   const Icon(
//                     Icons.app_registration,
//                     size: 100,
//                     color: Colors.white,
//                   ),
//                   const SizedBox(height: 50),
//                   Text(
//                     'Create an account to get started!',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: _controllerUsername,
//                           keyboardType: TextInputType.name,
//                           decoration: getUsernameInputDecoration(),
//                           onEditingComplete: () =>
//                               _focusNodePassword.requestFocus(),
//                           style: TextStyle(color: Colors.white),
//                           validator: UsernameInputValidator.validate,
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           controller: _controllerEmail,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: getEmailInputDecoration(),
//                           onEditingComplete: () =>
//                               _focusNodePassword.requestFocus(),
//                           style: TextStyle(color: Colors.white),
//                           validator: EmailInputValidator.validate,
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           controller: _controllerPassword,
//                           focusNode: _focusNodePassword,
//                           obscureText: _obscurePassword,
//                           keyboardType: TextInputType.visiblePassword,
//                           decoration: getPasswordInputDecoration(
//                               _obscurePassword, togglePasswordVisibility),
//                           style: TextStyle(color: Colors.white),
//                           validator: PasswordInputValidator.validate,
//                         ),
//                         const SizedBox(height: 24),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                           child: RegisterButton(
//                             onTap: _isRegistering
//                                 ? null
//                                 : () => registerUser(context),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "Already have an account? ",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => LoginScreen(),
//                                   ),
//                                 );
//                               },
//                               child: const Text(
//                                 "Login",
//                                 style: TextStyle(
//                                   color: Colors.orange,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (_isRegistering)
//               Container(
//                 color: Colors.black54,
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../components/register_button.dart';
import '../components/user_inputs/email_input_decoration.dart';
import '../components/user_inputs/email_input_validator.dart';
import '../components/user_inputs/password_input_decoration.dart';
import '../components/user_inputs/password_input_validator.dart';
import '../components/user_inputs/username_input_decoration.dart';
import '../components/user_inputs/username_input_validator.dart';

import 'login_screen.dart';
import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeRepeatPassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerRepeatPassword =
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
            builder: (context) => OtpScreen(),
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
    _focusNodePassword.dispose();
    _focusNodeRepeatPassword.dispose();
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerRepeatPassword.dispose();
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
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  // const Icon(
                  //   Icons.app_registration,
                  //   size: 100,
                  //   color: Colors.white,
                  // ),
                      Image.asset(
                "assets/logo.png",
                fit: BoxFit.cover,
              ),
                  const SizedBox(height: 10),
                  Text(
                    'Create an account to get started!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controllerUsername,
                          keyboardType: TextInputType.name,
                          decoration: getUsernameInputDecoration(),
                          onEditingComplete: () =>
                              _focusNodePassword.requestFocus(),
                          style: TextStyle(color: Colors.white),
                          validator: UsernameInputValidator.validate,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _controllerEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: getEmailInputDecoration(),
                          onEditingComplete: () =>
                              _focusNodePassword.requestFocus(),
                          style: TextStyle(color: Colors.white),
                          validator: EmailInputValidator.validate,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _controllerPassword,
                          focusNode: _focusNodePassword,
                          obscureText: _obscurePassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: getPasswordInputDecoration(
                            _obscurePassword,
                            togglePasswordVisibility,
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: PasswordInputValidator.validate,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _controllerRepeatPassword,
                          focusNode: _focusNodeRepeatPassword,
                          obscureText: _obscureRepeatPassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: getPasswordInputDecoration(
                            _obscureRepeatPassword,
                            toggleRepeatPasswordVisibility,
                            label: 'Repeat Password',
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value != _controllerPassword.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: RegisterButton(
                            onTap: _isRegistering
                                ? null
                                : () => registerUser(context),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account? ",
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
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Login",
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
            if (_isRegistering)
              Container(
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

