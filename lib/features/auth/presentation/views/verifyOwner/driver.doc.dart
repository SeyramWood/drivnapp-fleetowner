import 'package:drivn/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn/shared/errors/error.alert.dart';
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
      appBar: AppBar(
        backgroundColor: blue,
        foregroundColor: white,
      ),
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
              Text("Upload your official driver's license",
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
                  child: context.watch<UserAuthProvider>().files.isNotEmpty
                      ? Center(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(5),
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(20))),
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(
                                vertical: 50, horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                context.watch<UserAuthProvider>().files.length,
                                (index) {
                                  String filename = context
                                      .watch<UserAuthProvider>()
                                      .files[index]
                                      .path
                                      .split('/')
                                      .last;
                                  return Text(
                                    '(${index + 1}) $filename',
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      : null),
              CustomElevatedButton(
                onPressed: () async {
                  var files = context.read<UserAuthProvider>().files;
                  LoadingDialog.showLoadingDialog(context);
                  // if (provider.files == null) return;
                  await provider
                      .submitUserDoc(context,files,provider.userID)
                      .then((value) {
                    LoadingDialog.hideLoadingDialog(context);
                    Navigator.of(context).pop();

                    if (value is String) {
                      return showErrorDialogue(context, value);
                    }
                    context.read<UserAuthProvider>().emptyFiles();
                    return ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                      content: Text('Added successfully'),
                    ));
                  });
                },
                backgroundColor: black,
                child: const Text('Submit for review'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
