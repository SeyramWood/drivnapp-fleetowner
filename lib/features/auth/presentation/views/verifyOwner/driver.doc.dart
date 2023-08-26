import 'package:drivn/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:drivn/shared/utils/extentions/on.custom.elevated.button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user.auth.provider.dart';

class DriverDocsView extends StatelessWidget {
  const DriverDocsView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final provider = context.read<UserAuthProvider>();

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
                      context.read<UserAuthProvider>().selectFiles();
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      context.watch<UserAuthProvider>().files?.length ?? 0,
                      (index) {
                        String filename = context
                            .watch<UserAuthProvider>()
                            .files![index]
                            .path
                            .split('/')
                            .last;
                        return Container(
                          padding: const EdgeInsets.all(10),
                          color: white,
                          child: Text(filename),
                        );
                      },
                    ),
                  ),
                ),
              ),
              CustomElevatedButton(
                onPressed: () {
                  if (provider.files!.isEmpty) return;
                  provider.submitUserID(context);
                },
                backgroundColor: black,
                child: const Text('Submit for review'),
              ).loading(provider.isLoading)
            ],
          ),
        ),
      ),
    );
  }
}
