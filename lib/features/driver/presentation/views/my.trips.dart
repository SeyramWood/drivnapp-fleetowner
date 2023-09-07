import 'package:drivn/features/driver/data/api/driver.api.service.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/trips.model.dart';
import '../widget/trip.card.dart';

class MyTrips extends StatefulWidget {
  const MyTrips({super.key});

  @override
  State<MyTrips> createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  late Future<List<DTrip>> trips;
  void fetchTrips() async {
    trips = DriverApiService().fetchTrips(context.read<APIService>().userId);
  }

  @override
  void initState() {
    fetchTrips();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: FutureBuilder(
            future: trips,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return const TripCard();
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No available vehicle.'));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
