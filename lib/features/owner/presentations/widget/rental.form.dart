import 'package:drivn/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn/features/owner/domain/entities/update.rental.model.dart';
import 'package:drivn/features/owner/presentations/widget/form.field.to.add.driver.dart';
import 'package:drivn/shared/errors/error.alert.dart';
import 'package:drivn/shared/utils/extentions/on.custom.elevated.button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../../google.places/location_search_screen.dart';
import '../../domain/entities/vehicle.model.dart';
import '../providers/owner.impl.dart';
import 'availability.textfield.dart';
import 'package:flutter/material.dart';

class UpdateRentalDialog extends StatefulWidget {
  final Vehicle vehicle;

  const UpdateRentalDialog({super.key, required this.vehicle});

  @override
  State<UpdateRentalDialog> createState() => _UpdateRentalDialogState();
}

class _UpdateRentalDialogState extends State<UpdateRentalDialog> {
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final driverController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with vehicle data here
    locationController.text = widget.vehicle.rental?.location ?? '';
    priceController.text = widget.vehicle.rental?.price.toString() ?? '';
    driverController.text =
        '${widget.vehicle.rental?.driver?.firstName ?? ''} ${widget.vehicle.rental?.driver?.lastName ?? ''}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update rental details')),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // AvailabilityTextField(
                //   onTap: () {
                //     // Show the AddLocationField as a bottom sheet
                //     showBottomSheet(
                //       context: context,
                //       builder: (context) {
                //         return const AddLocationField();
                //       },
                //     );
                //   },
                //   validator: (value) =>
                //       value!.isEmpty ? 'Please add location' : null,
                //   title: 'Location',
                //   readOnly: true,
                //   controller: locationController,
                //   prefixIcon:
                //       const ImageIcon(AssetImage('assets/icons/location.png')),
                // ),
                AddLocationField(
                  controller: locationController,
                  onLocationSelected: (value) {
                    setState(() {
                      locationController.text = value;
                    });
                  },
                ),
                AvailabilityTextField(
                  validator: (value) =>
                      value!.isEmpty ? 'Please add price' : null,
                  title: 'Price',
                  controller: priceController,
                  prefixIcon:
                      const ImageIcon(AssetImage('assets/icons/money-add.png')),
                ),
                const SizedBox(height: 10),
                DriverField(
                  controller: driverController,
                ),
                const SizedBox(height: 20),

                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: CustomElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          LoadingDialog.showLoadingDialog(context);
                          UpdateRentalModel updateRentalModel =
                              UpdateRentalModel(
                            location: locationController.text,
                            price: priceController.text,
                            driver: driverController.text
                                    .contains(RegExp('[a-zA-Z]'))
                                ? '${widget.vehicle.rental?.driver?.id}'
                                : driverController.text,
                          );

                          await context
                              .read<OwnerImplProvider>()
                              .updateRental(
                                  '${widget.vehicle.id}', updateRentalModel)
                              .then(
                            (failure) {
                              LoadingDialog.hideLoadingDialog(context);

                              if (failure is String && failure.isNotEmpty) {
                                showErrorDialogue(context, failure);
                              } else {
                                Navigator.of(context)
                                    .pop(widget.vehicle.availability);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Rental updated successfully'),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
