import 'dart:io';

import 'package:flutter/material.dart';

class NetworkErrorHandler {
  static void handleNetworkError(BuildContext context, dynamic error) {
    if (error is SocketException) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ErrorDialog(errorMessage: 'No internet connection');
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ErrorDialog(errorMessage: 'Network error occurred');
        },
      );
    }
  }
}



class ErrorDialog extends StatelessWidget {
  final String errorMessage;

  const ErrorDialog({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(errorMessage),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
