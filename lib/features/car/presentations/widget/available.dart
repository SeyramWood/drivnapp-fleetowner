import 'package:drivn_app/features/car/presentations/switch_icon_icons.dart';
import 'package:drivn_app/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/car.provider.dart';
import '../views/car.detail.dart';

class CarsAvailableBuilder extends StatefulWidget {
  const CarsAvailableBuilder({super.key});

  @override
  State<CarsAvailableBuilder> createState() => _CarsAvailableBuilderState();
}

class _CarsAvailableBuilderState extends State<CarsAvailableBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CarTile();
      },
    );
  }
}

class CarTile extends StatefulWidget {
  const CarTile({super.key});

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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CarDetails(),
          ),
        );
      },
      child: Card(
        color: white,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 3.5,
                child: Container(
                  padding: EdgeInsets.only(right: 5),
                  child: Image.asset('assets/car1.png'),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Mercedes Benz'),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                    SizedBox(height: 5),
                    Row(
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
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'GHS 900000',
                          style: TextStyle(fontSize: 15),
                        ),
                        Spacer(),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 3.2,
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: black.withOpacity(.2),
                                ),
                              ),
                              child: DropdownButton<int>(
                                isDense: true,
                                isExpanded: true,
                                iconSize: 25,
                                value: newValue,
                                onChanged: (value) {
                                  setState(() {
                                    newValue = value!;
                                  });
                                  // Check the selected value and take appropriate actions
                                  if (newValue == 2) {
                                    rideSharing();
                                  } else if (newValue == 1) {
                                    // Handle the case when "Unavailable" is selected
                                  } else if (newValue == 3) {
                                    // Handle the case when "Rental" is selected
                                  }
                                },
                                items: [
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

  void rideSharing() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RideSharingFormField(
                  title: 'Destination',
                  controller: TextEditingController(),
                  prefixIcon:
                      ImageIcon(AssetImage('assets/icons/location.png')),
                ),
                SizedBox(height: 10),
                RideSharingFormField(
                  title: 'Pick up location',
                  controller: TextEditingController(),
                  prefixIcon:
                      ImageIcon(AssetImage('assets/icons/location.png')),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _datePicker,
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text(
                                    '${context.watch<CarProvider>().date.day}/${context.watch<CarProvider>().date.month}/${context.watch<CarProvider>().date.year.toString().split('20').last}',
                                  ),
                                  Spacer(),
                                  ImageIcon(
                                      AssetImage('assets/icons/calendar.png')),
                                ],
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: _timePicker,
                        child: Card(
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
                                  Spacer(),
                                  ImageIcon(
                                      AssetImage('assets/icons/timer.png')),
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                RideSharingFormField(
                  title: 'Price',
                  controller: TextEditingController(),
                  prefixIcon:
                      ImageIcon(AssetImage('assets/icons/money-add.png')),
                ),
                Row(
                  children: [
                    Text('Number of seats'),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            '3',
                            style: TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add_circle_outline_outlined),
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
                child: Text('Done'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RideSharingFormField extends StatelessWidget {
  const RideSharingFormField({
    super.key,
    this.controller,
    required this.prefixIcon,
    required this.title,
  });
  final TextEditingController? controller;
  final Widget prefixIcon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: yellow),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: blue),
            ),
          ),
        ),
      ],
    );
  }
}
