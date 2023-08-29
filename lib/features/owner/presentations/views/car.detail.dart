import 'package:drivn/features/owner/presentations/widget/car.carousel.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Car details')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3.5,
              child: const CarCarousel(),
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Car ID:idhiei53i  ',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const Icon(Icons.copy)
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
                        const Icon(
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
                    const Divider(),
                    Text(
                      'All Features',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisExtent: 150,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => const Card(
                  surfaceTintColor: white,
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
                childCount: 20, // Replace with your actual number of items
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const ImageIcon(AssetImage('assets/icons/edit.png')),
      ),
    );
  }
}
