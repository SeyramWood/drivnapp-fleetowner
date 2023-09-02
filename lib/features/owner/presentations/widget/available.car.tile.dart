import 'package:flutter/material.dart';
import 'package:drivn/features/owner/presentations/switch_icon_icons.dart';
import 'package:drivn/features/owner/presentations/widget/ride.sharing.form.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/available.vehicles.dart' as data;
import '../providers/available.or.booked.dart';
import '../views/car.detail.dart';

class CarTile extends StatefulWidget {
  const CarTile({super.key, required this.vehicle});
  final data.Vehicle vehicle;
  @override
  State<CarTile> createState() => _CarTileState();
}

class _CarTileState extends State<CarTile> {
  int newValue = 1;

  //date picker
  void _datePicker() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then(
      (value) {
        context.read<CarProvider>().setDate = value!;
      },
    );
  }

  //time picker
  void _timePicker() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      context.read<CarProvider>().setTime = selectedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    var vehicle = widget.vehicle;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 600),
            child:  CarDetails(vehicle:vehicle),
          ),
        );
      },
      child: Card(
        color: white,
        surfaceTintColor: white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 3.5,
                child: Container(
                  padding: const EdgeInsets.only(right: 5),
                  child: Image.asset('assets/car1.png'),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(vehicle.brand),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            children: [
                              Text(
                                'With driver',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                SwitchIcon.toggle_on,
                                color: red,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          color: yellow,
                        ),
                        Text('4.8'),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          'GHS 900000',
                          style: TextStyle(fontSize: 15),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 3.2,
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: black.withOpacity(.1),
                                ),
                              ),
                              child: DropdownButton<int>(
                                isDense: true,
                                isExpanded: true,
                                iconSize: 25,
                                underline: Container(),
                                value: newValue,
                                onChanged: (value) {
                                  setState(() {
                                    newValue = value!;
                                  });
                                  // Check the selected value and take appropriate actions
                                  if (newValue == 2) {
                                    rideSharing(
                                      context,
                                      _datePicker,
                                      _timePicker,
                                    );
                                  } else if (newValue == 1) {
                                    // Handle the case when "Unavailable" is selected
                                  } else if (newValue == 3) {
                                    // Handle the case when "Rental" is selected
                                  }
                                },
                                items: const [
                                  DropdownMenuItem<int>(
                                    value: 1,
                                    child: Text(
                                      'Unavailable',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  DropdownMenuItem<int>(
                                    value: 2,
                                    child: Text(
                                      'Ride sharing',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  DropdownMenuItem<int>(
                                    value: 3,
                                    child: Text(
                                      'Rental',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),

                    // //this container has the car's name and it's ratings
                    // Container(
                    //   padding: EdgeInsets.all(5),
                    //   height: 45,
                    //   decoration: BoxDecoration(
                    //     color: black.withOpacity(0.1),
                    //     border: Border.all(color: black.withOpacity(0.2)),
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    // child: Row(children: [
                    //   Text('Mercedes Benz'),
                    //   Spacer(),
                    //   Icon(
                    //     Icons.star_border_outlined,
                    //     color: yellow,
                    //   ),
                    //   Text('4.8')
                    // ]),
                    // ),
                    // SizedBox(height: 15),
                    // /*
                    //  */
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Text(
                    //       'GHS 9000',
                    //       style: TextStyle(fontSize: 12),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    //       child: Row(
                    //         children: [
                    //           Text(
                    //             'With driver',
                    //             style: TextStyle(fontSize: 12),
                    //           ),
                    //           SizedBox(width: 5),
                    //           Icon(
                    //             SwitchIcon.toggle_on,
                    //             color: yellow,
                    //             size: 10,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // // SizedBox(
                    // //   width: MediaQuery.sizeOf(context).width / 3,
                    // //   child: DropdownButton(
                    // //     isDense: true,
                    // //     isExpanded: true,
                    // //     iconSize: 15,
                    // //     value: 2,
                    // //     onChanged: (value) {},
                    // //     items: [
                    // //       DropdownMenuItem<int>(
                    // //         value: 1,
                    // //         child: Text(
                    // //           'Unavailable',
                    // //           style: TextStyle(fontSize: 12),
                    // //         ),
                    // //       ),
                    // //       DropdownMenuItem<int>(
                    // //         value: 2,
                    // //         child: Text(
                    // //           'Ride sharing',
                    // //           style: TextStyle(fontSize: 12),
                    // //         ),
                    // //       ),
                    // //       DropdownMenuItem<int>(
                    // //         value: 3,
                    // //         child: Text(
                    // //           'Rental',
                    // //           style: TextStyle(fontSize: 12),
                    // //         ),
                    // //       ),
                    // //     ],
                    // //   ),
                    // // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
