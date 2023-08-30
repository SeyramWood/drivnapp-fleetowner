import 'package:drivn/features/owner/data/api/owner.api.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/available.car.tile.dart';

OwnerApiService apiService = OwnerApiService();

class CarsAvailableBuilder extends StatefulWidget {
  const CarsAvailableBuilder({super.key});

  @override
  State<CarsAvailableBuilder> createState() => _CarsAvailableBuilderState();
}

class _CarsAvailableBuilderState extends State<CarsAvailableBuilder> {
  Future? cars;

  @override
  void initState() {
    super.initState();
    cars = apiService.fetchCars(context.read<APIService>().userID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cars,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return const CarTile();
            },
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('No available vehicle.'));
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
