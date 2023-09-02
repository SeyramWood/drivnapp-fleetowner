import 'dart:io';

import 'package:drivn/features/auth/presentation/views/validating.view.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../widget/elevated.button.dart';

class VerifyDriverView extends StatefulWidget {
  const VerifyDriverView({super.key});

  @override
  State<VerifyDriverView> createState() => _VerifyDriverViewState();
}

class _VerifyDriverViewState extends State<VerifyDriverView> {
  Future<List<File>> selectFiles(files) async {
    final fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (fileResult != null) {
      var fileList = fileResult.files
          .map((platformFile) => File(platformFile.path.toString()))
          .toList();
      setState(() {
        files = fileList;
      });
      return files;
    }
    return [];
  }

  List<File> idCardFiles = [];
  List<File> licenceFiles = [];
  List<String> selectedOptions = [];

  List<String> allOptions = [
    ' A',
    ' B',
    ' C',
    ' D',
  ];
  var space = const SizedBox(
    height: 10,
  );
  final licenceType = TextEditingController();
  final licenceNumber = TextEditingController();
  final yearsOfExperience = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    licenceType.dispose();
    licenceNumber.dispose();
    yearsOfExperience.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Driver Verification')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(children: [
            space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('National ID'),
                CustomElevatedButton(
                  onPressed: () async {
                    final fileResult = await FilePicker.platform
                        .pickFiles(allowMultiple: true);
                    if (fileResult != null) {
                      idCardFiles = fileResult.files
                          .map((platformFile) =>
                              File(platformFile.path.toString()))
                          .toList();
                    }
                    // context
                    //     .read<UserAuthProvider>()
                    //     .selectFiles(file: idCardFiles);
                    // selectFiles(idCardFiles);
                  },
                  backgroundColor:
                      selectedOptions.isNotEmpty ? Colors.green : black,
                  child: Text(selectedOptions.isNotEmpty
                      ? '${selectedOptions.length} file selected'
                      : 'Add file'),
                )
              ],
            ),
            space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Driving License'),
                CustomElevatedButton(
                  onPressed: () async {
                    final fileResult = await FilePicker.platform
                        .pickFiles(allowMultiple: true);
                    if (fileResult != null) {
                      licenceFiles = fileResult.files
                          .map((platformFile) =>
                              File(platformFile.path.toString()))
                          .toList();
                    }

                    // context
                    //     .read<UserAuthProvider>()
                    //     .selectFiles(file: licenceFiles);
                  },
                  backgroundColor:
                      selectedOptions.isNotEmpty ? Colors.green : black,
                  child: Text(selectedOptions.isNotEmpty
                      ? '${selectedOptions.length} file selected'
                      : 'Add file'),
                )
              ],
            ),
            space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('License Type'),
                MyFormField(
                  controller: licenceType,
                  // suffixIcon: DropdownButton(items: [DropdownMenuItem(child: Text('A'),value: 'A',)]),
                )
              ],
            ),
            space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('License Number'),
                MyFormField(
                  controller: licenceNumber,
                )
              ],
            ),
            space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Years of experience'),
                MyFormField(
                  controller: yearsOfExperience,
                  keyboardType: TextInputType.number,
                )
              ],
            ),
            space,
            space,
            space,
            space,
            space,
            SizedBox(
              width: 200,
              child: CustomElevatedButton(
                onPressed: () {
                  context.read<APIService>().submitData(
                        idCardFiles: idCardFiles,
                        licenseFiles: licenceFiles,
                        licenseNumber: licenceNumber.text,
                        licenseType: licenceType.text,
                        yearsOfExperience: 8,
                      );
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const VerifyingView(),
                  ));
                },
                child: const Text('Submit for review'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class MyFormField extends StatelessWidget {
  MyFormField({super.key, required this.controller, this.keyboardType});
  final TextEditingController controller;
  TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: yellow),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: yellow),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: yellow),
        ),
      ),
    );
  }
}
