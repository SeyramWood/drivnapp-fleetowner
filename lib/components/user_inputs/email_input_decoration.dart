import 'package:flutter/material.dart';

// InputDecoration getEmailInputDecoration() {
//   return InputDecoration(
//     filled: true,
//     fillColor: Colors.white.withOpacity(0.1),
//     hintText: 'Email',
//     hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
//     contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8.0),
//       borderSide: BorderSide.none,
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8.0),
//       borderSide: BorderSide.none,
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8.0),
//       borderSide: BorderSide.none,
//     ),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8.0),
//       borderSide: BorderSide(color: Colors.red),
//     ),
//     focusedErrorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8.0),
//       borderSide: BorderSide(color: Colors.red),
//     ),
//   );
// }

InputDecoration getEmailInputDecoration() {
  return InputDecoration(
    labelText: "Email",
    labelStyle: TextStyle(color: Colors.orange),
    prefixIcon: const Icon(Icons.email_outlined,
        color: Colors.black), // Set the icon color to black
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}
