import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}
