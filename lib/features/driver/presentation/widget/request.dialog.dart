import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../../../shared/utils/constants/dimensions.dart';
import '../../../auth/presentation/widget/elevated.button.dart';

class RequestInfo extends StatelessWidget {
  const RequestInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var space = const SizedBox(
      height: 15,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
          const LocAndTime(),
          space,
          const LocAndTime(),
          space,
          divider,
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
          divider,
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
                    child: const Text('reject'),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => BottomSheet(
                              builder: (context) => SizedBox(
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
                                          child: const Text('call'),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Message'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onClosing: () {},
                            ));
                  },
                  child: const Text('Accept'),
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
            const SizedBox(height: 5),
            Container(
              width: MediaQuery.sizeOf(context).width * .5,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: yellow,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: const Row(
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
        const Spacer(),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('23th July, 2023',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            Container(
              width: MediaQuery.sizeOf(context).width * .3,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: yellow,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: const Center(child: Text('10:57 AM')),
            )
          ],
        )
      ],
    );
  }
}