import 'package:flutter/material.dart';

InputDecoration getUsernameInputDecoration() {
  return InputDecoration(
    labelText: "Username",
    labelStyle: TextStyle(color: Colors.orange),
    prefixIcon: const Icon(Icons.person_outline, color: Colors.black), // Set the icon color to black
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
