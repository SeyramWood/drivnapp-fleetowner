import 'package:drivn/features/owner/presentations/widget/widgets.for.booked.cars.dart';
import 'package:flutter/material.dart';

class BookedCarsBuilder extends StatelessWidget {
  const BookedCarsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: cars,
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
