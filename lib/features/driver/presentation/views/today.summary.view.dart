import 'package:drivn/features/driver/presentation/views/ride.info.view.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../widget/summary.container.dart';

class TodaySummaryView extends StatelessWidget {
  const TodaySummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        const SliverToBoxAdapter(
          child: Text('Tue, Aug 15, 2023'),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        const SliverToBoxAdapter(
          child: Row(
            children: [
              SummaryContainer(
                title: '0',
                subTitle: 'Trips',
                color: red,
              ),
              SizedBox(
                width: 10,
              ),
              SummaryContainer(
                title: '0',
                subTitle: 'Hours',
                color: yellow,
              ),
              SizedBox(
                width: 10,
              ),
              SummaryContainer(
                title: 'Ghc 0.00',
                subTitle: 'Earned',
                color: blue,
              ),
            ],
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return const SummaryTile();
          },
        )
      ],
    );
  }
}

class SummaryTile extends StatelessWidget {
  const SummaryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const RideInfoView(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: red, width: 0.5),
              right: BorderSide(color: red, width: 0.5),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('12:45'),
                  const SizedBox(width: 15),
                  Text(
                    'John Doe',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  const Text('\$30'),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: grey),
                    child: const Text('AM'),
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      const ImageIcon(
                        AssetImage('assets/icons/location.png'),
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'location',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
