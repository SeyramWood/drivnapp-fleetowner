import 'package:drivn_app/features/driver/presentation/widget/request.dialog.dart';
import 'package:drivn_app/shared/utils/constants/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../../auth/presentation/widget/elevated.button.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key});

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(
      height: 15,
    );
    return Card(
      surfaceTintColor: white,
      color: white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            space,
            ListTile(
              leading: Image.asset('assets/car1.png'),
              title: Text(
                'Mecedies Benz',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
              ),
              subtitle: Text(
                'GT - 3452 45',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            space,
            LocAndTime(),
            space,
            LocAndTime(),
            space,
            divider,
            space,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Duration',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  '20 hours',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            space,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text('\$200',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            space,
            divider,
            space,
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    height: 40,
                    child: CustomElevatedButton(
                      backgroundColor: red,
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.call_outlined),
                          Text('Call'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 140,
                    height: 40,
                    child: CustomElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.message_outlined),
                          Text('Message'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            space,
          ],
        ),
      ),
    );
  }
}
