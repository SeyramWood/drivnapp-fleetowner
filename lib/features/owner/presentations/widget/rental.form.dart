import 'package:drivn/features/owner/data/api/owner.api.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/constants/colors.dart';
import 'availability.textfield.dart';

updateRental(BuildContext context, int id) {
  final locationcontroller = TextEditingController();
  final pricecontroller = TextEditingController();
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
                controller: locationcontroller,
                prefixIcon:
                    const ImageIcon(AssetImage('assets/icons/location.png')),
              ),
              const SizedBox(height: 10),
              AvailabilityTextField(
                title: 'Price',
                controller: pricecontroller,
                prefixIcon:
                    const ImageIcon(AssetImage('assets/icons/money-add.png')),
              ),
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
                    .updateRental('$id', 0,
                        locationcontroller.text, pricecontroller.text)
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
