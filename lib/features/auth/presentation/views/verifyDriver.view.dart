import 'package:drivn_app/features/auth/presentation/views/validating.view.dart';
import 'package:drivn_app/features/auth/presentation/widget/formfield.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../../car/presentations/widget/form.field.dart';
import '../../../car/presentations/widget/multi.selection.dialog.dart';
import '../widget/elevated.button.dart';

class VerifyDriverView extends StatefulWidget {
  const VerifyDriverView({super.key});

  @override
  State<VerifyDriverView> createState() => _VerifyDriverViewState();
}

class _VerifyDriverViewState extends State<VerifyDriverView> {
  final licenseController = TextEditingController();
  final yearsController = TextEditingController();
  List<String> selectedOptions = [];

  List<String> allOptions = [
    'Option 1',
    'Option 2',
    'Option 4',
    'Option 4',
    'Option 3',
  ];
  var space = SizedBox(
    height: 10,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Driver Verification')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(children: [
            space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('National ID'),
                CustomElevatedButton(
                  onPressed: () {},
                  child: Text(selectedOptions.isNotEmpty
                      ? '${selectedOptions.length} file selected'
                      : 'Add file'),
                  backgroundColor:
                      selectedOptions.isNotEmpty ? Colors.green : black,
                )
              ],
            ),
            space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Driving License'),
                CustomElevatedButton(
                  onPressed: openMultiSelectDialog,
                  child: Text(selectedOptions.isNotEmpty
                      ? '${selectedOptions.length} file selected'
                      : 'Add file'),
                  backgroundColor:
                      selectedOptions.isNotEmpty ? Colors.green : black,
                )
              ],
            ),
            space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('License Type'),
                DropDownFormField(
                  controller: TextEditingController(),
                  labelText: '',
                ),
              ],
            ),
            space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('License Number'), MyFormField(controller: licenseController,)],
            ),
            space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Years of experience'), MyFormField(controller: yearsController,)],
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VerifyingView(),
                  ));
                },
                child: Text('Submit for review'),
              ),
            ),
          ]),
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

class MyFormField extends StatelessWidget {
  const MyFormField({super.key, required this.controller});
final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        
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
    );
  }
}
