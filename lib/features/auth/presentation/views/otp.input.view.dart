import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:drivn/shared/utils/extentions/on.custom.elevated.button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPInputView extends StatefulWidget {
  const OTPInputView({Key? key}) : super(key: key);

  @override
  State<OTPInputView> createState() => _OTPInputViewState();
}

class _OTPInputViewState extends State<OTPInputView> {
  final _formkey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter OTP',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontFamily: 'Inter', fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Image.asset(
                    "assets/otp.png",
                    fit: BoxFit.cover,
                    color: white,
                  ),
                ),
                const Text(
                  "Enter the 4 digits code via your sms",
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                otpFormField(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: CustomElevatedButton(
                    backgroundColor: black,
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        context
                            .read<UserAuthProvider>()
                            .verifyUser(
                              otpController.text,
                              context,
                            )
                            .then(
                              (value) => otpController.clear(),
                            );
                      }
                    },
                    child: const Text(
                      "Continue",
                    ),
                  ).loading(
                    context.watch<UserAuthProvider>().isLoading,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                        text: "Didn't get code? ",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                        children: const [
                          TextSpan(
                              text: 'Resend.',
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
        ),
      ),
    );
  }

  Widget otpFormField() {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Pinput(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Input a valid code';
            }
            return null;
          },
          controller: otpController,
          defaultPinTheme: PinTheme(
            height: 60,
            width: 60,
            textStyle: const TextStyle(
              fontSize: 25,
            ),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          focusedPinTheme: PinTheme(
            height: 60,
            width: 60,
            textStyle: const TextStyle(
              fontSize: 25,
            ),
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(
                color: white,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          submittedPinTheme: PinTheme(
            height: 60,
            width: 60,
            textStyle: const TextStyle(
              fontSize: 25,
            ),
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(
                color: white,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
