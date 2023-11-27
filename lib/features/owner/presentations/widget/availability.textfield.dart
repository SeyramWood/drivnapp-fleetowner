import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';

class AvailabilityTextField extends StatelessWidget {
  const AvailabilityTextField({
    super.key,
    this.controller,
    required this.prefixIcon,
    required this.title,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
  });
  final TextEditingController? controller;
  final Widget prefixIcon;
  final String title;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool readOnly;
  final void Function()? onTap;
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
          readOnly: readOnly,
          controller: controller,
          validator: validator,
          onTap: onTap,
          onChanged: onChanged,
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
