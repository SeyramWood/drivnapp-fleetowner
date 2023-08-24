// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:drivn_app/shared/utils/constants/colors.dart';

class DropDownFormField extends StatefulWidget {
  const DropDownFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  @override
  State<DropDownFormField> createState() => _DropDownFormFieldState();
}

class _DropDownFormFieldState extends State<DropDownFormField> {
  String selectedValue = '';

  List<String> options = [
    'Option 1',
    'Option 2',
    'Option 4',
    'Option 4',
    'Option 3',
    'Option 3',
    'Option 3',
    'Option 6',
    'Option 3',
    'Option 3',
    'Option 3',
    'Option 8',
    'Option 3',
    'Option 3',
    'Option 3',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SafeArea(
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: widget.labelText,
              suffixIcon: RotatedBox(
                quarterTurns: -1,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: black.withOpacity(.4),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: yellow),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: yellow),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: yellow),
              ),
            ),
          ),
          suggestionsCallback: (pattern) async {
            return options.where((option) =>
                option.toLowerCase().contains(pattern.toLowerCase()));
          },
          itemBuilder: (context, option) {
            return ListTile(title: Text(option));
          },
          onSuggestionSelected: (option) {
            this.widget.controller.text = option;
            print(options);
          },
        ),
      ),
    );
  }
}
