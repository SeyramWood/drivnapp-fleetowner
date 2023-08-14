import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../../auth/presentation/widget/elevated.button.dart';

class RequestInfo extends StatelessWidget {
  const RequestInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var space = SizedBox(
      height: 15,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Duration',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600)),
              Text('20 hours',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600)),
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
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 40,
                  child: CustomElevatedButton(
                    backgroundColor: red,
                    onPressed: () {},
                    child: Text('reject'),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => BottomSheet(
                              builder: (context) => Container(
                                height: 100,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        height: 40,
                                        child: CustomElevatedButton(
                                          backgroundColor: red,
                                          onPressed: () {},
                                          child: Text('call'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text('Message'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onClosing: () {},
                            ));
                  },
                  child: Text('Accept'),
                )
              ],
            ),
          ),
          space,
        ],
      ),
    );
  }
}

class LocAndTime extends StatelessWidget {
  const LocAndTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Car pick up location',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            Container(
              width: MediaQuery.sizeOf(context).width * .5,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: yellow,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/icons/location_tick.png'),
                  ),
                  Text(
                    'Circle Main Station',
                  ),
                ],
              ),
            )
          ],
        ),
        Spacer(),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('23th July, 2023',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Container(
              width: MediaQuery.sizeOf(context).width * .3,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: yellow,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(child: Text('10:57 AM')),
            )
          ],
        )
      ],
    );
  }
}
