import 'package:drivn/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DriverDocsView extends StatelessWidget {
  const DriverDocsView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: AppBar(backgroundColor: blue),
        backgroundColor: blue,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Driving document',
                    style: Theme.of(context).textTheme.headlineLarge),
                Text('Upload your official driving license',
                    style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(
                  height: height * .1,
                ),
                Card(
                  color: black.withOpacity(.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: SizedBox(
                    width: width,
                    child: TextButton.icon(
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles();
                        if (result == null) return;
                        final file = result.files.first;
                        print(file.name);
                      },
                      icon: const Icon(
                        Icons.file_copy,
                      ),
                      label: const Text('Add a file'),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(white)),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 2.5,
                ),
                CustomElevatedButton(
                  onPressed: () {},
                  backgroundColor: black,
                  child: const Text('Submit for review'),
                )
              ],
            ),
          ),
        ));
  }
}
