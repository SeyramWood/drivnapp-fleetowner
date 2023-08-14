import 'package:drivn_app/features/auth/presentation/widget/elevated.button.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../widget/request.tile.dart';

class RequestView extends StatefulWidget {
  const RequestView({super.key});

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: DropdownButton<int>(
                      // isDense: true,
                      // isExpanded: true,
                      iconSize: 30,
                      underline: Container(),
                      value: 1,
                      // icon: RotatedBox(
                      //     quarterTurns: -1, child: Icon(Icons.arrow_back_ios)),
                      onChanged: (value) {},
                      items: [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text(
                            'Accra,Ghana',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text(
                            'Ride sharing',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 3,
                          child: Text(
                            'Rental',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text('offline'),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      onChanged: (value) {},
                      value: false,
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return RequestInfo();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RequestInfo extends StatelessWidget {
  const RequestInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              LocAndTime(),
              LocAndTime(),
              Row(
                children: [
                  Text('Duration'),
                  Text('20 hours'),
                ],
              ),
              Row(
                children: [
                  Text('Price'),
                  Text('\$200'),
                ],
              ),
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
                      onPressed: () {},
                      child: Text('Accept'),
                    )
                  ],
                ),
              )
            ]),
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
