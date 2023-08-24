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
  });

  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        // autofocus: true,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: yellow),
          prefixIconColor: white,
          suffixIconColor: white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 50),
          prefixIcon: prefixIcon,
          prefix: prefix,
          suffixIcon: Icon(suffixIcon),
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
    );
  }
}
