import 'dart:io';

import 'package:drivn_app/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn_app/features/auth/presentation/widget/formfield.dart';
import 'package:drivn_app/features/car/presentations/widget/form.field.dart';
import 'package:drivn_app/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../widget/multi.selection.dialog.dart';

class Add_A_Car_Form extends StatefulWidget {
  const Add_A_Car_Form({super.key});

  @override
  State<Add_A_Car_Form> createState() => _Add_A_Car_FormState();
}

class _Add_A_Car_FormState extends State<Add_A_Car_Form> {
  final space = SizedBox(
    height: 10,
  );
  List<String> selectedOptions = [];

  List<String> allOptions = [
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

  void openMultiSelectDialog() async {
    final result = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          options: allOptions,
          selectedOptions: selectedOptions,
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedOptions = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Car')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddCarFormField(
                controller: TextEditingController(),
                labelText: 'Car Brand',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: RotatedBox(
                    quarterTurns: -1,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: black.withOpacity(.4),
                    ),
                  ),
                ),
              ),
              space,
              AddCarFormField(
                controller: TextEditingController(),
                labelText: 'Car Type',
                suffixIcon: DropdownButton(
                  // isDense: true,
                  // isExpanded: true,
                  iconSize: 25,
                  icon: RotatedBox(
                    quarterTurns: -1,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: black.withOpacity(.4),
                    ),
                  ),
                  value: 2,
                  onChanged: (value) {},
                  items: [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text(
                        'Unavailable',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text(
                        'Ride sharing',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text(
                        'Rental',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              space,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add image'),
                  CustomElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result == null) return;
                      final file = result.files.first;
                      print(file.name);
                    },
                    child: Text('Add a file'),
                    backgroundColor: blue,
                  )
                ],
              ),
              space,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Proof of ownership'),
                  CustomElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result == null) return;
                      final file = result.files.first;
                      print(file.name);
                    },
                    child: Text('Add a file'),
                    backgroundColor:blue,
                  )
                ],
              ),
              space,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('More features'),
                  CustomElevatedButton(
                    onPressed: openMultiSelectDialog,
                    child: Text('Add features'),
                    backgroundColor: blue,
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 7,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.sizeOf(context).width / 1.5,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Done'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(blue),
                  ),
                ),
              ),
              space
            ],
          ),
        ),
      ),
    );
  }
}
