import 'dart:io';

import 'package:drivn/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:drivn/shared/errors/error.alert.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../data/api/owner.api.dart';
import '../widget/multi.selection.dialog.dart';

class AddFleetForm extends StatefulWidget {
  const AddFleetForm({super.key});

  @override
  State<AddFleetForm> createState() => _AddFleetFormState();
}

class _AddFleetFormState extends State<AddFleetForm> {
  final carBrand = TextEditingController();
  final carType = TextEditingController();
  final space = const SizedBox(
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

  List<File> imageFile = [];
  List<File> proofFile = [];
  OwnerApiService apiService = OwnerApiService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Car')),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // DropDownFormField(
                //   controller: carBrand,
                //   labelText: 'Car Brand',
                // ),

                // DropDownFormField(
                //   controller: carType,
                //   labelText: 'Car Type',
                // ),
                FormWithOption(
                  labelText: 'Car Brand',
                  controller: carBrand,
                ),
                space,
                FormWithOption(
                  labelText: 'Car Type',
                  controller: carType,
                ),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Add image'),
                    CustomElevatedButton(
                      onPressed: () async {
                        final result = await FilePicker.platform
                            .pickFiles(allowMultiple: true);
                        if (result != null) {
                          imageFile = result.files
                              .map(
                                (file) => File(file.path.toString()),
                              )
                              .toList();
                          setState(() {});
                        }

                        print(imageFile);
                      },
                      backgroundColor:
                          imageFile.isNotEmpty ? Colors.green : blue,
                      child: Text(imageFile.isNotEmpty
                          ? '${imageFile.length} File selected'
                          : 'Add image'),
                    )
                  ],
                ),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Proof of ownership'),
                    CustomElevatedButton(
                      onPressed: () async {
                        final result = await FilePicker.platform
                            .pickFiles(allowMultiple: true);
                        if (result != null) {
                          proofFile = result.files
                              .map(
                                (file) => File(file.path.toString()),
                              )
                              .toList();
                          setState(() {});
                        }
                        print(proofFile);
                      },
                      backgroundColor:
                          proofFile.isNotEmpty ? Colors.green : blue,
                      child: Text(proofFile.isNotEmpty
                          ? '${proofFile.length} File selected'
                          : 'Add a file'),
                    )
                  ],
                ),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Add features'),
                    CustomElevatedButton(
                      onPressed: openMultiSelectDialog,
                      backgroundColor:
                          selectedOptions.isNotEmpty ? Colors.green : blue,
                      child: Text(
                        selectedOptions.isNotEmpty
                            ? '${selectedOptions.length} features selected'
                            : 'Add features',
                      ),
                    )
                  ],
                ),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Optional'),
                    CustomElevatedButton(
                      onPressed: () {},
                      child: const Text('More features'),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 15,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.5,
                  child: CustomElevatedButton(
                    onPressed: () {
                      apiService
                          .submitData(
                              userID: context.read<APIService>().userID,
                              carBrand: carBrand.text,
                              carType: carType.text,
                              feature: selectedOptions,
                              imageFiles: imageFile,
                              proofFiles: proofFile)
                          .then((failure) {
                        if (failure != null) {
                          showErrorDialogue(
                            context,
                            failure,
                          );
                        }
                      });
                    },
                    backgroundColor: blue,
                    child: const Text('Done'),
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

// ignore: must_be_immutable
class FormWithOption extends StatefulWidget {
  FormWithOption({
    super.key,
    required this.controller,
    required this.labelText,
  });
  TextEditingController controller;
  String labelText;

  @override
  State<FormWithOption> createState() => _FormWithOptionState();
}

class _FormWithOptionState extends State<FormWithOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText),
        // Autocomplete<String>(
        //   optionsBuilder: (textEditingValue) {
        //     if (textEditingValue.text.isEmpty) {
        //       return const Iterable.empty();
        //     }
        //     return allOptions.where(
        //       (element) {
        //         return element.contains(textEditingValue.text);
        //       },
        //     );
        //   },
        //   fieldViewBuilder:
        //       (context, textEditingController, focusNode, onFieldSubmitted) {
        //     widget.controller = textEditingController;
        //     return
        TextFormField(
          controller: widget.controller,
          onEditingComplete: () {},
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: yellow),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: yellow),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: yellow),
            ),
            // hintText: "Search Something",
          ),
          onChanged: (value) {},
        )
        //   },
        // ),
      ],
    );
  }
}
