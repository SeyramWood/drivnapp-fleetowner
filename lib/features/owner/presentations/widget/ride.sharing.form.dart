import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../providers/available.or.booked.dart';
import 'availability.textfield.dart';

//on ride sharing selected

void rideSharing(
  BuildContext context,
  datePicker,
  timePicker,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      surfaceTintColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AvailabilityTextField(
                title: 'Destination',
                controller: TextEditingController(),
                prefixIcon:
                    const ImageIcon(AssetImage('assets/icons/location.png')),
              ),
              const SizedBox(height: 10),
              AvailabilityTextField(
                title: 'Pick up location',
                controller: TextEditingController(),
                prefixIcon:
                    const ImageIcon(AssetImage('assets/icons/location.png')),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: datePicker,
                      child: Card(
                          surfaceTintColor: white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  '${context.watch<CarProvider>().date.day}/${context.watch<CarProvider>().date.month}/${context.watch<CarProvider>().date.year.toString().split('20').last}',
                                ),
                                const Spacer(),
                                const ImageIcon(
                                    AssetImage('assets/icons/calendar.png')),
                              ],
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: timePicker,
                      child: Card(
                          surfaceTintColor: white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  context
                                      .watch<CarProvider>()
                                      .time
                                      .format(context)
                                      .toString(),
                                ),
                                const Spacer(),
                                const ImageIcon(
                                    AssetImage('assets/icons/timer.png')),
                              ],
                            ),
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              AvailabilityTextField(
                title: 'Price',
                controller: TextEditingController(),
                prefixIcon:
                    const ImageIcon(AssetImage('assets/icons/money-add.png')),
              ),
              Row(
                children: [
                  const Text('Number of seats'),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        const Text(
                          '3',
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_circle_outline_outlined),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      actions: [
        Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width / 3,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Done'),
            ),
          ),
        )
      ],
    ),
  );


}
