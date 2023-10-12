import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/show.snacbar.dart';
import '../../../../shared/utils/cached.network.image.dart';
import '../../../../shared/utils/constants/colors.dart';
import 'package:drivn/features/owner/domain/entities/vehicle.model.dart';
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
                                  .deleteVehicleDocument('${document.id}');
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
        onPressed: () {
          showCustomSnackBar(context, 'Yet to be implemented');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
