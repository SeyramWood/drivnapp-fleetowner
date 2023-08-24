import 'package:flutter/material.dart';

import '../widget/trip.card.dart';

class MyTrips extends StatelessWidget {
  const MyTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const TripCard();
          },
        ),
      ),
    );
  }
}
