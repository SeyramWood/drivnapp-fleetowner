import 'package:drivn/features/owner/data/api/owner.api.dart';
import 'package:drivn/features/owner/presentations/widget/form.field.to.add.driver.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import 'availability.textfield.dart';

updateRental(BuildContext context, int id) {
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final driverController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      surfaceTintColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AvailabilityTextField(
                validator: (p0) => p0!.isEmpty ? 'Please add location' : null,
                title: 'Location',
                controller: locationController,
                prefixIcon:
                    const ImageIcon(AssetImage('assets/icons/location.png')),
              ),
              const SizedBox(height: 10),
              AvailabilityTextField(
                validator: (p0) => p0!.isEmpty ? 'Please add price' : null,
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
                if (formkey.currentState!.validate()) {
                  OwnerApiService()
                      .updateRental(
                    '$id',
                    driverController.text,
                    locationController.text,
                    priceController.text,
                  )
                      .then(
                    (value) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Rental updated successfully'),
                        ),
                      );
                    },
                  );
                }
              },
              child: const Text('Update'),
            ),
          ),
        )
      ],
    ),
  );
}
