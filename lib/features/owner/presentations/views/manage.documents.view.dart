import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/show.snacbar.dart';
import '../../../../shared/utils/cached.network.image.dart';
import '../../../../shared/utils/constants/colors.dart';
import 'package:drivn/features/owner/domain/entities/vehicle.model.dart';
import '../../../auth/presentation/providers/user.auth.provider.dart';
import '../providers/owner.impl.dart';

class ManageDocumentsView extends StatelessWidget {
  final Vehicle vehicle;

  const ManageDocumentsView({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Vehicle Documents')),
      body: ListView.builder(
        itemCount: vehicle.documents?.length,
        itemBuilder: (BuildContext context, int index) {
          final document = vehicle.documents![index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10.0),
                      ),
                      child: SizedBox(
                        height: 200,
                        child: showImage(
                          imageUrl: document.document,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            onPressed: () async {
                              final fileResult =
                                  await FilePicker.platform.pickFiles();

                              if (fileResult != null) {
                                final pickedFile = fileResult.files.map(
                                    (platformFile) =>
                                        File(platformFile.path.toString()));
                                if (context.mounted) {
                                  final result = await context
                                      .read<OwnerImplProvider>()
                                      .updateVehicleDocument(
                                          '${document.id}', pickedFile.first);
                                  result.fold(
                                      (failure) =>
                                          showCustomSnackBar(context, failure,red),
                                      (success) =>
                                          showCustomSnackBar(context, success,green));
                                }
                              }
                            },
                            icon: const Icon(Icons.edit),
                            label: const Text('Update'),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              final result = await context
                                  .read<OwnerImplProvider>()
                                  .deleteVehicleDocument('${document.id}');
                              result.fold(
                                  (failure) =>
                                      showCustomSnackBar(context, failure,red),
                                  (success) =>
                                      showCustomSnackBar(context, success,green));
                            },
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(red)),
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete'),
                          )
                        ],
                      )),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.read<UserAuthProvider>().selectFiles();
          // ignore: use_build_context_synchronously
          final files = context.read<UserAuthProvider>().files;
          // var limit = files.length + vehicle.documents!.length <=
          //     5; //checking not to exceed the expect vehicle images

          if (files.isNotEmpty) {
            if (context.mounted) {
              final result = await context
                  .read<OwnerImplProvider>()
                  .addVehicleDocument(vehicle.id.toString(), files);
              result.fold((failure) => showCustomSnackBar(context, failure,red),
                  (success) => showCustomSnackBar(context, success,green));
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
