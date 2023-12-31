import 'package:drivn/features/owner/presentations/views/booked.cars.view.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../providers/change.content.dart';
import 'available.cars.view.dart';

class MyCars extends StatelessWidget {
  const MyCars({super.key});

  @override
  Widget build(BuildContext context) {
    final AvailabelOrBooked clicked = AvailabelOrBooked();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: const Text('My Cars')),
      body: ValueListenableBuilder(
        valueListenable: clicked,
        builder: (ctx, stateOfContainer, child) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: yellow),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => clicked.isClicked(true),
                        child: Container(
                          height: 35,
                          width: MediaQuery.sizeOf(context).width / 2,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5)),
                            color: stateOfContainer ? blue : white,
                          ),
                          child: Center(
                            child: Text(
                              'Available',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 20,
                                    color: stateOfContainer ? white : black,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => clicked.isClicked(false),
                        child: Container(
                          height: 35,
                          width: MediaQuery.sizeOf(context).width / 2,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                            color: stateOfContainer ? white : blue,
                          ),
                          child: Center(
                            child: Text(
                              'Booked',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 20,
                                    color: stateOfContainer ? black : white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //custom body after the two taps after the appbar
            Expanded(
              child: SafeArea(
                  minimum:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  bottom: false,
                  child: stateOfContainer
                      ? CarsAvailableBuilder(
                          key: key,
                        )
                      : BookedCarsBuilder(
                          key: key,
                        )),
            )
          ],
        ),
      ),
    );
  }
}
