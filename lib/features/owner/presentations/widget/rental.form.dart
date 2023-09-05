import 'package:drivn/features/owner/data/api/owner.api.dart';
import 'package:drivn/features/owner/presentations/widget/form.field.to.add.driver.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import 'availability.textfield.dart';

updateRental(BuildContext context, int id) {
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final driverController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      surfaceTintColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AvailabilityTextField(
                title: 'Location',
                controller: locationController,
                prefixIcon:
                    const ImageIcon(AssetImage('assets/icons/location.png')),
              ),
              const SizedBox(height: 10),
              AvailabilityTextField(
                title: 'Price',
                controller: priceController,
                prefixIcon:
                    const ImageIcon(AssetImage('assets/icons/money-add.png')),
              ),
              const SizedBox(height: 10),
              DriverField(
                controller: driverController,
              )
            ],
          ),
        ),
      ),
      actions: [
        Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width / 3,
            child: ElevatedButton(
              onPressed: () {
                OwnerApiService()
                    .updateRental(
                        '$id', 0, locationController.text, priceController.text)
                    .then(
                      (value) => Navigator.of(context).pop(),
                    );
              },
              child: const Text('Update'),
            ),
          ),
        )
      ],
    ),
  );
}
