import 'dart:developer';

import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn/features/user/data/api/user.api.service.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:drivn/shared/utils/extentions/on.custom.elevated.button.dart';
import 'package:drivn/shared/utils/shared.prefs.manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/errors/error.alert.dart';

class ProofIDView extends StatelessWidget {
  const ProofIDView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final provider = context.read<UserApiService>();
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
                        context.read<UserAuthProvider>().selectFiles();
                      },
                      icon: const Icon(
                        Icons.file_copy,
                      ),
                      label: const Text('Add a file (Front and Back)'),
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
                      : null,
                ),
                CustomElevatedButton(
                  onPressed: () async {
                    LoadingDialog.showLoadingDialog(context);
                    await provider
                        .submitDoc(context.read<UserAuthProvider>().files)
                        .then((value) {
                      Navigator.of(context).pop();
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
        ));
  }
}
