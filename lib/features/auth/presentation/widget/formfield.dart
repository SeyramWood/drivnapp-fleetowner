import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.obscureText,
    this.textInputAction =TextInputAction.next,
  });

  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool? obscureText;
  final TextInputAction? textInputAction ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(color: yellow),
          ),
          TextFormField(
            controller: controller,
            obscureText: obscureText ?? false,
            obscuringCharacter: '*',
            textInputAction: textInputAction,
            cursorColor: white,
            decoration: InputDecoration(
              suffixIconColor: white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: white),
              ),
            ),
            style: const TextStyle(color: white),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
