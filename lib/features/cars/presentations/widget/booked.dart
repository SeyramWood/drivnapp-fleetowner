import 'package:flutter/material.dart';

class BookedCarsBuilder extends StatelessWidget {
  const BookedCarsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(
          height: 200,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'No complete medication recognised',
          ),
        ),
      ],
    );
  }
}
