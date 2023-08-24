import 'package:drivn_app/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import '';
import '../../../auth/presentation/views/verifyDriver.view.dart';

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
        title: Text('Ride Info'),
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
            Text('Total trip earns'),
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
              subtitle: Text('car number'),
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
                Text('asdfjo09'),
              ],
            ),
            SizedBox(height: 5),
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
                Text('asdfjo09'),
              ],
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Car pickup location'),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: yellow),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
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
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer pickup location'),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: yellow),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
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
