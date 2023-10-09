import 'dart:io';

import 'package:drivn/features/owner/presentations/providers/owner.impl.dart';
import 'package:drivn/shared/show.snacbar.dart';
import 'package:drivn/shared/utils/cached.network.image.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import 'package:drivn/features/owner/domain/entities/vehicle.model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ManageImagesView extends StatelessWidget {
  final Vehicle vehicle;
  const ManageImagesView({Key? key, required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Vehicle Images')),
      body: ListView.builder(
        itemCount: vehicle.images.length,
        itemBuilder: (BuildContext context, int index) {
          final image = vehicle.images[index];
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
                            onPressed: () {
                              showCustomSnackBar(
                                  context, 'Yet to be implemented');
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
                                      showCustomSnackBar(context, failure),
                                  (success) =>
                                      showCustomSnackBar(context, success));
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
           showCustomSnackBar(
                                  context, 'Yet to be implemented');
    //        final picker = ImagePicker();
    // final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    // if (pickedImage != null) {
    //   var pickedImage0 = File(pickedImage.path);

    //   if (context.mounted) {
    //     await context
    //         .read<OwnerImplProvider>()
    //         .addVehicleImage(pickedImage0, context)
    //         .then(
    //           (value) => getProfile(),
    //         );
    //   }
    // }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
