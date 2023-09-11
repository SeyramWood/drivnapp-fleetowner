import 'package:drivn/features/owner/domain/entities/booked.vehicle.model.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../data/api/owner.api.dart';

class MoreOfBookedCar extends StatelessWidget {
  const MoreOfBookedCar({super.key, required this.info});
  final BookedVehicle? info;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView(
        padding: const EdgeInsets.all(10),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 130,
        ),
        children: [
          ActionCard(
            color: yellow,
            text: 'Track',
            info: info,
            onTap: () {},
          ),
          ActionCard(
            onTap: info?.bookingStatus != 'successful'
                ? () {
                    var bookingID = info!.id.toString();
                    OwnerApiService().endTrip(bookingID);
                  }
                : null,
            info: info,
            text: 'End Trip',
            color: blue,
          ),
          ActionCard(
            color: red,
            text: 'Report issue',
            info: info,
            onTap: () {},
          )
        ],
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.info,
    required this.color,
    required this.text,
    required this.onTap,
  });

  final BookedVehicle? info;
  final String text;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          color: color,
          shadowColor: white,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: white),
            ),
          )),
    );
  }
}
