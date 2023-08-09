import 'package:drivn_app/features/car/presentations/switch_icon_icons.dart';
import 'package:drivn_app/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

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

  rideSharing() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Destination'),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: white))),
                )
              ],
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pick up location'),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: yellow))),
                )
              ],
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Done'),
          )
        ],
      ),
    );
  }
}
