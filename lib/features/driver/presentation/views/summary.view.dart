import 'package:drivn_app/features/driver/presentation/provider/toggle.dart';
import 'package:drivn_app/features/driver/presentation/views/today.summary.view.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Summary')),
      body: ValueListenableBuilder(
          valueListenable: Toggled(),
          builder: (context, state, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: yellow),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Toggled().isClicked(true),
                            child: Container(
                              height: 35,
                              width: MediaQuery.sizeOf(context).width / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5)),
                                color: state ? blue : white,
                              ),
                              child: Center(
                                child: Text(
                                  'Today',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        fontSize: 20,
                                        color: state ? white : black,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Toggled().isClicked(false),
                            child: Container(
                              height: 35,
                              width: MediaQuery.sizeOf(context).width / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                                color: state ? white : blue,
                              ),
                              child: Center(
                                child: Text(
                                  'Weekly',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        fontSize: 20,
                                        color: state ? black : white,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // --------------------------------------------
                  TodaySummaryview(),
                ],
              ),
            );
          }),
    );
  }
}
