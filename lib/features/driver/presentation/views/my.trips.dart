import 'dart:async';

import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/driver/presentation/provider/driver.impl.provider.dart';
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
  late List<DTrip> trips;
  final StreamController<List<DTrip>> _streamController = StreamController();
// ignore: unused_field
  late Timer _timer;
  void fetchTrips() async {
    if (mounted && !_streamController.isClosed) {
      final data = await context
          .read<DriverImplProvider>()
          .fetchTrips(context.read<UserAuthProvider>().userID);

      if (data is List<DTrip>) {
        var streamData = data;
        _streamController.sink.add(streamData);
      }
    }
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      fetchTrips();
    });
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
          child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    var request = snapshot.data?[index];
                    return TripCard(
                      tripInfo: request,
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text(
                        'Nothing to show here.\nComplete or accept a\ntrip request to see it here.'));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
