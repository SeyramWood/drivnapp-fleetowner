import 'dart:async';

import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/owner/presentations/providers/owner.impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/vehicle.model.dart';
import '../widget/available.car.tile.dart';

class CarsAvailableBuilder extends StatefulWidget {
  const CarsAvailableBuilder({Key? key}) : super(key: key);

  @override
  State<CarsAvailableBuilder> createState() => _CarsAvailableBuilderState();
}

class _CarsAvailableBuilderState extends State<CarsAvailableBuilder> {
  late List<Vehicle> vehicles;
  final StreamController<List<Vehicle>> _controller = StreamController();
  late Timer _timer;
  void fetchVehicles() async {
    if (mounted) {
      var futureData = await context
          .read<OwnerImplProvider>()
          .fetchVehicles(context.read<UserAuthProvider>().userID);
      if (futureData is List<Vehicle>) {
        var streamData = futureData;
        if (!_controller.isClosed) {
          _controller.sink.add(streamData);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        fetchVehicles();
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    _timer.cancel();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Vehicle>>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No available vehicle.'));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
