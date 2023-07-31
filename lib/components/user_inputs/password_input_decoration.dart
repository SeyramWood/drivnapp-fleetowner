
import 'package:flutter/material.dart';

InputDecoration getPasswordInputDecoration(
    bool obscureText, void Function() toggleVisibility,
    {String label = 'Password'}) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white.withOpacity(0),
    labelText: label, // Use the provided label
    // labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
    labelStyle: TextStyle(color: Colors.orange),
    prefixIcon: const Icon(Icons.password_outlined),

    contentPadding:
        const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(8.0),
      // borderSide: BorderSide.none,

      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(8.0),
      // borderSide: BorderSide.none,

      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.white),
    ),
    suffixIcon: IconButton(
      icon: Icon(
        obscureText ? Icons.visibility_off : Icons.visibility,
        color: Colors.white.withOpacity(0.6),
      ),
      onPressed: toggleVisibility,
    ),
  );
}
