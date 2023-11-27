import 'package:flutter/material.dart';
import '../owner/presentations/widget/availability.textfield.dart';
import 'components/location_list_tile.dart';
import 'components/network_utility.dart';
import 'constants.dart';
import 'models/autocomplate_prediction.dart';
import 'models/place_auto_complate_response.dart';

class AddLocationField extends StatefulWidget {
  final ValueChanged<String>? onLocationSelected;
  final TextEditingController controller;

  const AddLocationField(
      {Key? key, this.onLocationSelected, required this.controller})
      : super(key: key);

  @override
  State<AddLocationField> createState() => _AddLocationFieldState();
}

class _AddLocationFieldState extends State<AddLocationField> {
  List<AutocompletePrediction> placePredictions = [];
  TextEditingController _locationController = TextEditingController();
  bool isSearching = false;

  Future<void> placeAutocomplete(String query) async {
    final uri = Uri.https(
      "maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": apiKey,
      },
    );
    String? response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  void _onLocationSelected(String location) {
    _locationController.text = location;
    setState(() {
      isSearching = false;
    });
    widget.onLocationSelected?.call(location);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: AvailabilityTextField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      isSearching = true;
                    });
                  } else {
                    setState(() {
                      isSearching = false;
                    });
                  }
                  placeAutocomplete(value);
                },
                validator: (p0) => p0!.isEmpty ? 'Please add location' : null,
                title: 'Location',
                controller: _locationController = widget.controller,
                prefixIcon:
                    const ImageIcon(AssetImage('assets/icons/location.png')),
              ),
            ),
          ),
          Visibility(
            visible: isSearching,
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: placePredictions.length,
                itemBuilder: (context, index) {
                  return LocationListTile(
                    press: () {
                      _onLocationSelected(placePredictions[index].description!);
                    },
                    location: placePredictions[index].description!,
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
