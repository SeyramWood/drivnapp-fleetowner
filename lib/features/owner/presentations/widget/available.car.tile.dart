import 'package:drivn/features/owner/presentations/widget/rental.form.dart';
import 'package:drivn/shared/errors/error.alert.dart';
import 'package:drivn/shared/utils/cached.network.image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:drivn/features/owner/presentations/switch_icon_icons.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/vehicle.model.dart' as data;
import '../providers/owner.impl.dart';
import '../views/car.detail.dart';

class CarTile extends StatefulWidget {
  const CarTile({super.key, required this.vehicle});
  final data.Vehicle vehicle;
  @override
  State<CarTile> createState() => _CarTileState();
}

class _CarTileState extends State<CarTile> {
  String newValue = '';

  //date picker
  // void _datePicker() async {
  //   await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2050),
  //   ).then(
  //     (value) {
  //       context.read<CarProvider>().setDate = value!;
  //     },
  //   );
  // }

  //time picker
  // void _timePicker() async {
  //   final selectedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //   if (selectedTime != null) {
  //     context.read<CarProvider>().setTime = selectedTime;
  //   }
  // }

  @override
  initState() {
    newValue = widget.vehicle.availability;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vehicle = widget.vehicle;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 400),
            child: CarDetails(vehicle: vehicle),
          ),
        );
      },
      child: Slidable(
        dragStartBehavior: DragStartBehavior.down,
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context
                    .read<OwnerImplProvider>()
                    .deleteVehicle('${vehicle.id}');
              },
              backgroundColor: red,
              foregroundColor: white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Card(
          color: white,
          surfaceTintColor: white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 3.5,
                  height: 70,
                  child: showImage(
                    imageUrl: vehicle.images[0].image,
                    radius: 5,
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(vehicle.brand),
                          const Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              children: [
                                const Text(
                                  'With driver',
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  vehicle.rental?.driver != null
                                      ? SwitchIcon.toggle_on
                                      : SwitchIcon.toggle_off,
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
                          Text(
                            'GHC ${vehicle.rental?.price ?? 0}',
                            style: const TextStyle(fontSize: 15),
                          ),
                          const Spacer(),
                          //drop down button to select from as available or rental or sharing
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
                                child: DropdownButton<String>(
                                  isDense: true,
                                  isExpanded: true,
                                  iconSize: 25,
                                  underline: Container(),
                                  value: newValue,
                                  onChanged: (value) async {
                                    setState(() {
                                      newValue = value!;
                                    });
                                    // if (newValue == 2) {
                                    //   rideSharing(
                                    //     context,
                                    //     _datePicker,
                                    //     _timePicker,
                                    //   );
                                    // }
                                    // else
                                    if (newValue == 'unavailable') {
                                      context
                                          .read<OwnerImplProvider>()
                                          .updateAvailability(
                                              '${vehicle.id}', 'unavailable')
                                          .then(
                                        (failure) {
                                          if (failure != null) {
                                            showErrorDialogue(context, failure);
                                          }
                                        },
                                      );
                                    } else if (newValue == 'rental') {
                                      // await updateRental(context, vehicle);

                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateRentalDialog(
                                          vehicle: vehicle,
                                        ),
                                      ));
                                    }
                                  },
                                  items: const [
                                    DropdownMenuItem<String>(
                                      value: 'unavailable',
                                      child: Text(
                                        'Unavailable',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    // DropdownMenuItem<int>(
                                    //   value: 2,
                                    //   child: Text(
                                    //     'Ride sharing',
                                    //     style: TextStyle(fontSize: 13),
                                    //   ),
                                    // ),
                                    DropdownMenuItem<String>(
                                      value: 'rental',
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
      ),
    );
  }
}
