import 'package:drivn/features/owner/data/api/owner.api.dart';
import 'package:drivn/features/owner/presentations/widget/booked.vehicle.info.card.dart';
import 'package:drivn/features/user/data/api/user.api.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/booked.vehicle.model.dart';

class BookedCarsBuilder extends StatefulWidget {
  const BookedCarsBuilder({super.key});

  @override
  State<BookedCarsBuilder> createState() => _BookedCarsBuilderState();
}

class _BookedCarsBuilderState extends State<BookedCarsBuilder> {
  late Future<List<BookedVehicle>> bookedCars;
  @override
  void initState() {
    bookedCars = OwnerApiService()
        .fetchBookedVehicles(context.read<UserApiService>().userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bookedCars,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final info = snapshot.data![index];
              return InfoCard(
                info: info,
              );
            },
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text('Your booked vehicles will show here.'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
