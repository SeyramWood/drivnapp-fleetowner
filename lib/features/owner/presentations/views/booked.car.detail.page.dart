import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';

class MoreOfBookedCar extends StatelessWidget {
  const MoreOfBookedCar({super.key});

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
          Card(
              color: yellow,
              shadowColor: white,
              child: Center(
                child: Text(
                  'Track',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: white),
                ),
              )),
          Card(
              color: blue,
              shadowColor: white,
              child: Center(
                child: Text(
                  'End trip',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: white),
                ),
              )),
          Card(
              color: red,
              shadowColor: white,
              child: Center(
                child: Text(
                  'Report issue',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: white),
                ),
              )),
        ],
      ),
    );
  }
}
