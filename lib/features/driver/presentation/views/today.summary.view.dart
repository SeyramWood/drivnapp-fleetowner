import 'package:drivn_app/features/driver/presentation/widget/container.dart';
import 'package:drivn_app/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TodaySummaryview extends StatelessWidget {
  const TodaySummaryview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Tue, Aug 15, 2023'),
        Row(
          children: [
            SummaryContainer(
              title: 'Title',
              subTitle: 'SubTitle',
              color: red,
            ),
            SizedBox(width: 10,),
            SummaryContainer(
              title: 'Title',
              subTitle: 'SubTitle',
              color: yellow,
            ),
            SizedBox(width: 10,),
            SummaryContainer(
              title: 'Title',
              subTitle: 'SubTitle',
              color: blue,
            ),
          ],
        )
      ],
    );
  }
}
