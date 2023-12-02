import 'package:flutter/material.dart';

showErrorDialogue(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.sizeOf(context).height / 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(message),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('close'),
            )
          ],
        ),
      ),
    ),
  );
}
