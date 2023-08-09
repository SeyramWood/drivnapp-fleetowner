import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';

class MultiSelectDialog extends StatefulWidget {
  final List<String> options;
  final List<String> selectedOptions;

  MultiSelectDialog({required this.options, required this.selectedOptions});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<String> _selectedOptions = [];

  @override
  void initState() {
    super.initState();
    _selectedOptions = widget.selectedOptions;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(
        'Select Options',
        style: TextStyle(color: black),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: widget.options.map((option) {
            return Row(
              children: [
                Checkbox(
                  value: widget.selectedOptions.contains(option),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        widget.selectedOptions.add(option);
                      } else {
                        widget.selectedOptions.remove(option);
                      }
                    });
                  },
                ),
                SizedBox(width: 8), // Adjust spacing between checkbox and text
                Text(option),
              ],
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, _selectedOptions);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
