import 'package:drivn/features/owner/data/api/owner.api.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../domain/entities/driver.model.dart';

// ignore: must_be_immutable
class DriverField extends StatefulWidget {
  DriverField({super.key, required this.controller});
  // void Function(String) onSelected;
  TextEditingController controller;

  @override
  State<DriverField> createState() => _DriverFieldState();
}

class _DriverFieldState extends State<DriverField> {
  List<Dryver> driverLists = [];
  getDrivers() async {
    List<Dryver> drivers = await OwnerApiService().fetchDrivers();
    for (var driver in drivers) {
      driverLists.add(driver);
    }
  }

  @override
  void initState() {
    getDrivers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Driver (Optional)'),
        Autocomplete<String>(
          initialValue: widget.controller.value,
          onSelected: (selectedOption) {
            var selectedDriver = driverLists.firstWhere((driver) =>
                '${driver.firstName} ${driver.lastName}' == selectedOption);
            widget.controller.text = selectedDriver.id.toString();
          },
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable.empty();
            }
            return driverLists.map(
              (driver) => '${driver.firstName} ${driver.lastName}',
            );
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: textEditingController,
              focusNode: focusNode,
              onEditingComplete: onFieldSubmitted,
              onTapOutside: (event) {
                const PointerDownEvent(obscured: true);
              },
              onFieldSubmitted: (value) {
                // widget.controller.clear();
              },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: blue),
                ),
                // hintText: "Search Something",
              ),
              onChanged: (value) {
                // widget.controller.text = value;
              },
              onSaved: (newValue) {
                // textEditingController.clear();
              },
            );
          },
        ),
      ],
    );
  }
}
