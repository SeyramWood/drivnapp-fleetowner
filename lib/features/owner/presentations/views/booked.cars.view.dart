import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/owner/presentations/providers/owner.impl.dart';
import '../../domain/entities/booked.vehicle.model.dart';
import '../widget/booked.vehicle.info.card.dart';

class BookedCarsBuilder extends StatefulWidget {
  const BookedCarsBuilder({Key? key}) : super(key: key);

  @override
  State<BookedCarsBuilder> createState() => _BookedCarsBuilderState();
}

class _BookedCarsBuilderState extends State<BookedCarsBuilder> {
  Future<List<BookedVehicle>>? bookedVehicles;

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

  void fetchVehicles() async {
    if (mounted) {
      final userID = context.read<UserAuthProvider>().userID;
      final futureData =
          await context.read<OwnerImplProvider>().fetchBookedVehicles(userID);
      if (futureData is List<BookedVehicle>) {
        setState(() {
          bookedVehicles = Future.value(futureData);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookedVehicle>>(
      future: bookedVehicles,
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
