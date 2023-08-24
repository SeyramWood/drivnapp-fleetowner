import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class RideInfoView extends StatefulWidget {
  const RideInfoView({super.key});

  @override
  State<RideInfoView> createState() => _RideInfoViewState();
}

class _RideInfoViewState extends State<RideInfoView> {
  final cardesController = TextEditingController();
  final cusdesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Text(
              '\$ 120',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: black),
            ),
            const Text('Total trip earns'),
            ListTile(
              leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.asset('assets/car1.png')),
              title: Text(
                'car name',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('car number'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trip duration',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const Text('asdfjo09'),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const Text('asdfjo09'),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Car pickup location'),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: yellow),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    children: [
                      ImageIcon(
                        AssetImage('assets/icons/location.png'),
                      ),
                      Text('Location'),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Customer pickup location'),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: yellow),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    children: [
                      ImageIcon(
                        AssetImage('assets/icons/location.png'),
                      ),
                      Text('Location'),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
