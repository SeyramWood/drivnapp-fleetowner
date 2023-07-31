import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String selectedOption = 'Unavailable'; // Set the initial value here.

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: <String>['Unavailable', 'Rent', 'Ride sharing']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedOption = newValue ?? 'Unavailable';
        });
      },
      value: selectedOption,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('DropdownButton Example'),
      ),
      body: Center(
        child: MyDropdownButton(),
      ),
    ),
  ));
}
