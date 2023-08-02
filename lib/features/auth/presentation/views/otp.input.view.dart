import 'package:drivn_app/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'verifyOwner/verify.user.view.dart';

class OTPInputView extends StatelessWidget {
  const OTPInputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Enter OTP',
              style: TextStyle(
                color: white,
                fontSize: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Image.asset(
                "assets/otp.png",
                fit: BoxFit.cover,
                color: white,
              ),
            ),
            Text(
              "Enter the 4 digits code via your email",
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GetVerifiedOption(),
                    ),
                  );
                },
                child: Text(
                  "Verify",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: RichText(
                text: TextSpan(
                    text: "Don't get code? ",
                    style: TextStyle(
                      color: black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
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
    );
  }

  Widget otpFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Pinput(
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
    );
  }
}
