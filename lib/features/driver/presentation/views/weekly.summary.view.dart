import 'package:drivn_app/features/driver/presentation/views/today.summary.view.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../widget/summary.container.dart';

class WeeklySummaryView extends StatelessWidget {
  const WeeklySummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 15,
          ),
        ),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.arrow_back_ios_new, color: yellow),
              Text('Mon 10 May 2023  -  Sun 16 May 2023'),
              Icon(Icons.arrow_forward_ios, color: yellow),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 15),
        ),
        WeeklySummaryCart(),
        SliverToBoxAdapter(
          child: SizedBox(height: 15),
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

class WeeklySummaryCart extends StatelessWidget {
  const WeeklySummaryCart({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      height: MediaQuery.sizeOf(context).height / 4,
      decoration:
          BoxDecoration(color: black, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              7,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //background container//
                      Container(
                        height: 150,
                        width: 30,
                        decoration: BoxDecoration(
                            // color: grey.withOpacity(.3),
                            borderRadius: BorderRadius.circular(60)),
                        padding: EdgeInsets.all(13),
                        //second indicator bg//
                        child: Container(
                            color: grey,
                            //main indicator//
                            child: Container(
                              height: 5,
                              color: blue,
                            )),
                      ),
                      Text(
                        'Day',
                        style: TextStyle(
                          color: grey.withOpacity(.3),
                        ),
                      )
                    ],
                  ),
                );
              },
            )),
      ),
    ));
  }
}
