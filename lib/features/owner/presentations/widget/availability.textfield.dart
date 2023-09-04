import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';

class AvailabilityTextField extends StatelessWidget {
  const AvailabilityTextField({
    super.key,
    this.controller,
    required this.prefixIcon,
    required this.title,
  });
  final TextEditingController? controller;
  final Widget prefixIcon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: yellow),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: blue),
            ),
          ),
        ),
      ],
    );
  }
}
