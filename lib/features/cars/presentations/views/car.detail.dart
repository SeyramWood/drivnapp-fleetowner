import 'package:drivn_app/features/cars/presentations/widget/car.carousel.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Car details')),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 3.5,
              child: CarCarousel(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0)
                  .copyWith(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'Car ID:idhiei53i  ',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Icon(Icons.copy)
                    ],
                  ),
                  Text(
                    'Car model',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'Car name',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_border_outlined,
                        color: yellow,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: '4.8',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          TextSpan(
                            text: '  (200+ review)',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: black.withOpacity(.4)),
                          )
                        ]),
                      )
                    ],
                  ),
                  Divider(),
                  Text(
                    'All Features',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 2.3,
                    child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisExtent: 150,
                      ),
                      children: [
                        Card(
                          color: white,
                          shadowColor: white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.auto_awesome),
                              Text('Hello DRiVN'),
                              Text('Hello DRiVN'),
                            ],
                          ),
                        ),
                        Card(
                          color: white,
                          shadowColor: white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.auto_awesome),
                              Text('Hello DRiVN'),
                              Text('Hello DRiVN'),
                            ],
                          ),
                        ),
                        Card(
                          color: white,
                          shadowColor: white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.auto_awesome),
                              Text('Hello DRiVN'),
                              Text('Hello DRiVN'),
                            ],
                          ),
                        ),
                        Card(
                          shadowColor: white,
                          color: white,
                          elevation: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.auto_awesome),
                              Text('Hello DRiVN'),
                              Text('Hello DRiVN'),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.edit_square,
          size: 40,
        ),
      ),
    );
  }
}
