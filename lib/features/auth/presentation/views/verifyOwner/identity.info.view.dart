import 'package:drivn_app/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn_app/shared/utils/constants/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProofIDView extends StatelessWidget {
  const ProofIDView({super.key});

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
                Text('Proof of Identity',
                    style: Theme.of(context).textTheme.headlineLarge),
                Text('We need to see your full name clearly printed on the ID',
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
                      icon: Icon(
                        Icons.file_copy,
                      ),
                      label: Text('Add a file'),
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
                  child: Text('Submit for review'),
                )
              ],
            ),
          ),
        ));
  }
}
