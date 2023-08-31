import 'dart:developer';
import 'dart:io';

import 'package:drivn/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:drivn/features/vehicle/data/api/vehicle.api.service.dart';
import 'package:drivn/shared/errors/error.alert.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import '../../data/api/owner.api.dart';
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
  final space = const SizedBox(
    height: 10,
  );
  List<String> selectedOptions = [];

  List<String> options = [];
  List<File> imageFile = [];
  List<File> proofFile = [];
  OwnerApiService apiService = OwnerApiService();
  //a method to pass the features to the list of options
  Future getFeatures() async {
    var result = await vehicleApiService.fetchFeatures();
    for (var feature in result) {
      options.add(feature.split('.')[1]);
    }
  }

  void clearFields() {
    imageFile.clear();
    proofFile.clear();
    selectedOptions.clear();
    carBrand.clear();
    carType.clear();
  }

  @override
  void initState() {
    getFeatures();
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
                    var text = value.split('.');
                    carBrand.text = text[1];
                  },
                  customOptionsBuilder: (String text) async {
                    final List<String> brands =
                        await vehicleApiService.fetchBrands();
                    List<String> carBrands = [];
                    for (var brand in brands) {
                      carBrands.add(brand.split('.')[0]);
                    }
                    return brands
                        .where((brand) => brand.contains(text))
                        .toList();
                  },
                ),
                space,
                FormWithOption(
                  labelText: 'Car Type',
                  controller: carType,
                  onSelected: (value) {
                    var text = value.split('.');
                    carType.text = text[1];
                  },
                  customOptionsBuilder: (String text) async {
                    final List<String> types =
                        await vehicleApiService.fetchTypes();
                    List<String> carTypes = [];
                    for (var type in types) {
                      carTypes.add(type.split('.')[1]);
                    }
                    return types
                        .where(
                          (type) => type.contains(text),
                        )
                        .toList();
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

                        print(imageFile);
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
                        print(proofFile);
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
                      onPressed: () {},
                      child: const Text('More features'),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 15,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.5,
                  child: CustomElevatedButton(
                    onPressed: () {
                      apiService
                          .submitData(
                        userID: context.read<APIService>().userID,
                        carBrand: carBrand.text,
                        carType: carType.text,
                        features: selectedOptions,
                        imageFiles: imageFile,
                        proofFiles: proofFile,
                      )
                          .then((failure) {
                        if (failure != null) {
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
                  ),
                ),
                space
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openMultiSelectDialog() async {
    final result = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          options: options,
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
}
