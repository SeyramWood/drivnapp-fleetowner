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
  final carBrand = TextEditingController();
  final carType = TextEditingController();
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

  PlatformFile? imageFile;
  PlatformFile? proofFile;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Add Car')),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AddCarFormField(
                  controller: carBrand,
                  labelText: 'Car Brand',
                ),
                space,
                AddCarFormField(
                  controller: carType,
                  labelText: 'Car Type',
                ),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add image'),
                    Visibility(
                      visible: imageFile != null ? true : false,
                      child: Center(
                        child: Text(imageFile?.name ?? ''),
                      ),
                    ),
                    CustomElevatedButton(
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles();
                        if (result == null) return;
                        setState(() {
                          imageFile = result.files.first;
                        });
                        print(imageFile!.name);
                      },
                      child: Text(imageFile != null
                          ? 'File selected (Double tap to remove)'
                          : 'Add a file'),
                      backgroundColor: imageFile != null ? Colors.green : blue,
                    )
                  ],
                ),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Proof of ownership'),
                    Visibility(
                      visible: proofFile != null ? true : false,
                      child: Center(
                        child: Text(proofFile?.name ?? ''),
                      ),
                    ),
                    CustomElevatedButton(
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles();
                        if (result == null) return;
                        setState(() {
                          proofFile = result.files.first;
                        });
                        print(proofFile!.name);
                      },
                      child: Text(proofFile != null
                          ? 'File selected (Double tap to remove)'
                          : 'Add a file'),
                      backgroundColor: proofFile != null ? Colors.green : blue,
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
                      child: Text(selectedOptions.isNotEmpty
                          ? '${selectedOptions.length} features selected'
                          : 'Add features'),
                      backgroundColor:
                          selectedOptions.isNotEmpty ? Colors.green : blue,
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 15,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.5,
                  child: CustomElevatedButton(
                    onPressed: () {},
                    child: Text('Done'),
                    backgroundColor: blue,
                  ),
                ),
                space
              ],
            ),
          ),
        ),
      ),
    );
  }

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
}
