import 'dart:io';

import 'package:drivn/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn/features/owner/domain/entities/vehicle.model.dart';
import 'package:drivn/features/owner/presentations/providers/owner.impl.dart';
import 'package:drivn/features/user/data/api/user.api.service.dart';
import 'package:drivn/features/vehicle/data/api/vehicle.api.service.dart';
import 'package:drivn/features/vehicle/domain/entities/vehicle.brands.dart';
import 'package:drivn/features/vehicle/domain/entities/vehicle.type.dart';
import 'package:drivn/shared/errors/error.alert.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:drivn/shared/utils/extentions/on.custom.elevated.button.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import '../../../vehicle/domain/entities/vehicle.features.dart' as sym;
import '../widget/form.field.with.option.dart';
import '../widget/multi.selection.dialog.dart';

VehicleApiService vehicleApiService = VehicleApiService();

class AddFleetForm extends StatefulWidget {
  const AddFleetForm({super.key});

  @override
  State<AddFleetForm> createState() => _AddFleetFormState();
}

class _AddFleetFormState extends State<AddFleetForm> {
  final carBrand = TextEditingController();
  final carType = TextEditingController();
  final optionalFeatures = TextEditingController();
  final space = const SizedBox(
    height: 10,
  );
  List<sym.Feature> selectedOptions = [];
//this list take vehicle features
  List<sym.Feature> featureList = [];
  //this list take vehicle brands
  List<Brand> brandList = [];
  //this list take vehicle type
  List<VType> vtypeList = [];

  List<File> imageFile = [];
  List<File> proofFile = [];

  //this method fetch the needed data asyncronosly and iterate into another local list variable for easy access at the init state

  Future getVehicleInfo() async {
    List<sym.Feature> features = await vehicleApiService.fetchFeatures();
    List<Brand> brands = await vehicleApiService.fetchBrands();
    List<VType> types = await vehicleApiService.fetchTypes();
    //iterate features
    for (var feature in features) {
      featureList.add(feature);
    }
    //iterate brands
    for (var brand in brands) {
      brandList.add(brand);
    }
    //iterate types
    for (var type in types) {
      vtypeList.add(type);
    }
  }

  void clearFields() {
    imageFile.clear();
    proofFile.clear();
    selectedOptions.clear();
    carBrand.clear();
    carType.clear();
    optionalFeatures.clear();
  }

  @override
  void initState() {
    getVehicleInfo();
    super.initState();
  }

// class's main build
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Car')),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormWithOption(
                  labelText: 'Car Brand',
                  controller: carBrand,
                  onSelected: (value) {
                    // Find the brand with the selected name and get its ID
                    final selectedBrand = brandList.firstWhere(
                      (brand) => brand.name == value,
                    );

                    carBrand.text = selectedBrand.id.toString();
                  },
                  //displays list items(vehicle brand) as a dropdown for easy selection
                  customOptionsBuilder: (String text) async {
                    return List.from(
                        brandList.map((vBrand) => vBrand.name).where(
                              (brand) => brand.contains(text),
                            ));
                  },
                  onSubmitted: (p0) {
                    carBrand.clear();
                  },
                ),
                space,
                FormWithOption(
                  labelText: 'Car Type',
                  controller: carType,
                  onSelected: (value) {
                    //find the selected name and get its id
                    final selectType = vtypeList.firstWhere(
                      (type) => type.name == value,
                    );
                    carType.text = selectType.id.toString();
                  },
                  //displays list items(vehicle types) as a dropdown for easy selection
                  customOptionsBuilder: (String text) async {
                    return List.from(vtypeList.map((vType) => vType.name).where(
                          (type) => type.isNotEmpty,
                        ));
                  },
                  onSubmitted: (p0) {
                    carBrand.clear();
                  },
                ),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Add image'),
                    CustomElevatedButton(
                      onPressed: () async {
                        final result = await FilePicker.platform
                            .pickFiles(allowMultiple: true);
                        if (result != null) {
                          imageFile = result.files
                              .map(
                                (file) => File(file.path.toString()),
                              )
                              .toList();
                          setState(() {});
                        }
                      },
                      backgroundColor:
                          imageFile.isNotEmpty ? Colors.green : blue,
                      child: Text(imageFile.isNotEmpty
                          ? '${imageFile.length} File selected'
                          : 'Add image'),
                    )
                  ],
                ),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Proof of ownership'),
                    CustomElevatedButton(
                      onPressed: () async {
                        final result = await FilePicker.platform
                            .pickFiles(allowMultiple: true);
                        if (result != null) {
                          proofFile = result.files
                              .map(
                                (file) => File(file.path.toString()),
                              )
                              .toList();
                          setState(() {});
                        }
                      },
                      backgroundColor:
                          proofFile.isNotEmpty ? Colors.green : blue,
                      child: Text(proofFile.isNotEmpty
                          ? '${proofFile.length} File selected'
                          : 'Add a file'),
                    )
                  ],
                ),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Add features'),
                    CustomElevatedButton(
                      onPressed: openMultiSelectDialog,
                      backgroundColor:
                          selectedOptions.isNotEmpty ? Colors.green : blue,
                      child: Text(
                        selectedOptions.isNotEmpty
                            ? '${selectedOptions.length} features selected'
                            : 'Add features',
                      ),
                    )
                  ],
                ),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Optional'),
                    CustomElevatedButton(
                      onPressed: showFieldForFeatures,
                      child: const Text('More features'),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 15,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.5,
                  //elevated button for submission of data
                  child: CustomElevatedButton(
                    onPressed: () {
                      LoadingDialog.showLoadingDialog(context);
                      VehicleToDBModel vehicle = VehicleToDBModel(
                          userID: context.read<UserApiService>().userId,
                          brand: carBrand.text,
                          type: carType.text,
                          features: List.from(selectedOptions
                              .map(
                                (feature) => feature.id.toString(),
                              )
                              .toList()),
                          images: imageFile,
                          documents: proofFile,
                          moreFeatures: optionalFeatures.text.trim());
                      context
                          .read<OwnerImplProvider>()
                          .addVehicle(vehicle)
                          .then((failure) {
                            LoadingDialog.hideLoadingDialog(context);
                        if (failure is String && failure.isNotEmpty) {
                          showErrorDialogue(
                            context,
                            failure,
                          );
                        } else {
                          clearFields();
                          setState(() {});
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration: Duration(seconds: 3),
                            content: Text('Vehicle added successfully'),
                          ));
                        }
                      });
                    },
                    backgroundColor: blue,
                    child: const Text('Done'),
                  ).loading(context.watch<OwnerImplProvider>().isLoading),
                ),
                space
              ],
            ),
          ),
        ),
      ),
    );
  }

//SHOW MULTI SELECT DIALOG TO SELECT VEHICLE FEATURES
  void openMultiSelectDialog() async {
    final List<sym.Feature>? result = await showDialog<List<sym.Feature>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          options: featureList,
          selectedOptions: selectedOptions,
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedOptions = result;
      });
    }
  }

  //optional features textfield
  showFieldForFeatures() {
    showDialog(
      context: context,
      builder: (context) {
        String enteredValue = ''; // Initialize with an empty string
        return AlertDialog(
          title: const Text(
            'Add more features',
            style: TextStyle(color: black),
          ),
          content: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors
                      .grey), // Optional: Add a border for visual separation
              borderRadius: BorderRadius.circular(
                  5.0), // Optional: Add border radius for rounded corners
            ),
            child: TextField(
              controller: TextEditingController(text: optionalFeatures.text),
              onChanged: (value) {
                enteredValue =
                    value; // Update the enteredValue as the user types
              },
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Separate each feature with a comma',
                hintStyle: TextStyle(overflow: TextOverflow.fade),
                border: InputBorder.none, // Remove the border
                contentPadding:
                    EdgeInsets.all(8.0), // Optional: Add padding for text input
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Use the enteredValue as needed
                optionalFeatures.text = enteredValue;
                Navigator.of(context).pop(enteredValue); // Close the dialog
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
