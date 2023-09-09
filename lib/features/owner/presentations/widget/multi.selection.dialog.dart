import 'package:drivn/features/vehicle/domain/entities/vehicle.features.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';

class MultiSelectDialog extends StatefulWidget {
  final List<Feature> options;
  final List<Feature> selectedOptions;

  const MultiSelectDialog(
      {super.key, required this.options, required this.selectedOptions});

  @override
  State<MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<Feature> _selectedOptions = [];

  @override
  void initState() {
    super.initState();
    _selectedOptions = widget.selectedOptions;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: const Text(
        'Select features',
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
                        print(widget.selectedOptions);
                      } else {
                        widget.selectedOptions.remove(option);
                        print(widget.selectedOptions);
                      }
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    option.name,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, _selectedOptions);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
