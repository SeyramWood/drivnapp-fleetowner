import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../widget/summary.container.dart';

class TodaySummaryView extends StatelessWidget {
  const TodaySummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverToBoxAdapter(
          child: Text('Tue, Aug 15, 2023'),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverToBoxAdapter(
          child: Row(
            children: [
              SummaryContainer(
                title: 'Title',
                subTitle: 'SubTitle',
                color: red,
              ),
              SizedBox(
                width: 10,
              ),
              SummaryContainer(
                title: 'Title',
                subTitle: 'SubTitle',
                color: yellow,
              ),
              SizedBox(
                width: 10,
              ),
              SummaryContainer(
                title: 'Title',
                subTitle: 'SubTitle',
                color: blue,
              ),
            ],
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return SummaryTile();
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: red, width: 0.5),
            right: BorderSide(color: red, width: 0.5),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text('12:45'),
                SizedBox(width: 20),
                Text(
                  'John Doe',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Spacer(),
                Text('\$30'),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: grey),
                  child: Text('AM'),
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    ImageIcon(
                      AssetImage('assets/icons/location.png'),
                      size: 20,
                      color: Colors.grey,
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
    );
  }
}
