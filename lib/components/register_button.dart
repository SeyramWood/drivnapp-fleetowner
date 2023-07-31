import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final Function()? onTap;

  const RegisterButton({Key? key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        // padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 0.0),
        width: double.infinity, // Set the width to occupy the available space
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Register",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
