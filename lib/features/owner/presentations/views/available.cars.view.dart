import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/api/owner.api.dart';
import '../../domain/entities/vehicle.model.dart';
import '../widget/available.car.tile.dart';

class CarsAvailableBuilder extends StatefulWidget {
  const CarsAvailableBuilder({Key? key}) : super(key: key);

  @override
  State<CarsAvailableBuilder> createState() => _CarsAvailableBuilderState();
}

class _CarsAvailableBuilderState extends State<CarsAvailableBuilder> {
  late Future<List<Vehicle>> vehicles;
  // String id = '';
  // getID() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   id = (prefs.getString('userID'));
  //   print(id);
  // }

  @override
  void initState() {
    super.initState();
    vehicles =
        OwnerApiService().fetchVehicles(context.read<APIService>().userId);
  }

  @override
  void didChangeDependencies() {
    vehicles =
        OwnerApiService().fetchVehicles(context.read<APIService>().userId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vehicle>>(
      future: vehicles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final vehicle = snapshot.data![index];
              return CarTile(
                vehicle: vehicle,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No available vehicle.'));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
