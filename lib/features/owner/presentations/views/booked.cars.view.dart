import 'package:drivn/features/owner/data/api/owner.api.dart';
import 'package:drivn/features/owner/presentations/widget/widgets.for.booked.cars.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookedCarsBuilder extends StatefulWidget {
  const BookedCarsBuilder({super.key});

  @override
  State<BookedCarsBuilder> createState() => _BookedCarsBuilderState();
}

class _BookedCarsBuilderState extends State<BookedCarsBuilder> {
  late Future bookedCars;
  @override
  void initState() {
    bookedCars = OwnerApiService()
        .fetchBookedVehicles(context.read<APIService>().userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bookedCars,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return const InfoCard();
            },
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('No booked vehicle.'));
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
