import 'package:drivn/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn/features/owner/domain/entities/update.rental.model.dart';
import 'package:drivn/features/owner/presentations/widget/form.field.to.add.driver.dart';
import 'package:drivn/shared/errors/error.alert.dart';
import 'package:drivn/shared/utils/extentions/on.custom.elevated.button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../domain/entities/vehicle.model.dart';
import '../providers/owner.impl.dart';
import 'availability.textfield.dart';

updateRental(BuildContext context, Vehicle vehicle) {
  final locationController =
      TextEditingController(text: vehicle.rental?.location);
  final priceController =
      TextEditingController(text: vehicle.rental?.price.toString());
  final driverController = TextEditingController(
      text:
          '${vehicle.rental?.driver?.firstName ?? ''} ${vehicle.rental?.driver?.lastName ?? ''}');
  final formkey = GlobalKey<FormState>();

  if (vehicle.rental?.driver?.firstName == null) {
    driverController.clear();
  }

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
            child: CustomElevatedButton(
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  LoadingDialog.showLoadingDialog(context);
                  UpdateRentalModel updateRentalModel = UpdateRentalModel(
                    location: locationController.text,
                    price: priceController.text,
                    driver: driverController.text.contains(RegExp('[a-zA-Z]'))
                        ? '${vehicle.rental?.driver?.id}'
                        : driverController.text,
                  );

                  await context
                      .read<OwnerImplProvider>()
                      .updateRental('${vehicle.id}', updateRentalModel)
                      .then(
                    (failure) {
                      LoadingDialog.hideLoadingDialog(context);

                      if (failure is String && failure.isNotEmpty) {
                        showErrorDialogue(context, failure);
                      } else {
                        Navigator.of(context).pop(vehicle.availability);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Rental updated successfully'),
                          ),
                        );
                      }
                    },
                  );
                }
              },
              child: const Text('Update'),
            ).loading(context.watch<OwnerImplProvider>().isLoading),
          ),
        )
      ],
    ),
  );
}
