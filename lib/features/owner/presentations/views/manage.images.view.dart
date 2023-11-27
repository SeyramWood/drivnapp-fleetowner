import 'dart:io';

import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/owner/presentations/providers/owner.impl.dart';
import 'package:drivn/shared/show.snacbar.dart';
import 'package:drivn/shared/utils/cached.network.image.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:drivn/features/owner/domain/entities/vehicle.model.dart';
import 'package:provider/provider.dart';

class ManageImagesView extends StatefulWidget {
  final Vehicle vehicle;
  const ManageImagesView({Key? key, required this.vehicle}) : super(key: key);

  @override
  State<ManageImagesView> createState() => _ManageImagesViewState();
}

class _ManageImagesViewState extends State<ManageImagesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Vehicle Images')),
      body: ListView.builder(
        itemCount: widget.vehicle.images.length,
        itemBuilder: (BuildContext context, int index) {
          final image = widget.vehicle.images[index];
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
                          imageUrl: image.image,
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
                                final pickedImage = fileResult.files.map(
                                    (platformFile) =>
                                        File(platformFile.path.toString()));
                                if (context.mounted) {
                                  final result = await context
                                      .read<OwnerImplProvider>()
                                      .updateVehicleImage(
                                          '${image.id}', pickedImage.first);
                                  result.fold(
                                      (failure) => showCustomSnackBar(
                                          context, failure, red),
                                      (success) => showCustomSnackBar(
                                          context, success, green));
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
                                  .deleteVehicleImage('${image.id}');
                              result.fold(
                                  (failure) =>
                                      showCustomSnackBar(context, failure, red),
                                  (success) => showCustomSnackBar(
                                      context, success, green));
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
          var limit = files.length + widget.vehicle.images.length <=
              5; //checking not to exceed the expect vehicle images

          if (files.isNotEmpty) {
            if (limit) {
              if (context.mounted) {
                final result = await context
                    .read<OwnerImplProvider>()
                    .addVehicleImage(widget.vehicle.id.toString(), files);
                result.fold(
                    (failure) => showCustomSnackBar(context, failure, red),
                    (success) => showCustomSnackBar(context, success, green));
              }
            } else {
              if (context.mounted) {
                showCustomSnackBar(
                    context, 'Ooops! A vehicle can have upto 5 images.', red);
              }
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
