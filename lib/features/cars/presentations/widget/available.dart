import 'package:drivn_app/features/cars/presentations/switch_icon_icons.dart';
import 'package:drivn_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CarsAvailableBuilder extends StatelessWidget {
  const CarsAvailableBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CarTile();
      },
    );
  }
}

class CarTile extends StatelessWidget {
  const CarTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width / 3.5,
            child: Container(
              padding: EdgeInsets.only(right: 5),
              child: Image.asset('assets/car1.png'),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                //this container has the car's name and it's ratings
                Container(
                  padding: EdgeInsets.all(5),
                  height: 45,
                  decoration: BoxDecoration(
                    color: black.withOpacity(0.1),
                    border: Border.all(color: black.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(children: [
                    Text('Mercedes Benz'),
                    Spacer(),
                    Icon(
                      Icons.star_border_outlined,
                      color: yellow,
                    ),
                    Text('4.8')
                  ]),
                ),
                SizedBox(height: 15),
                /*
                 */
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('\$ 20'),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'With driver',
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          SwitchIcon.toggle_on,
                          color: yellow,
                          size: 15,
                        )
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Text(
                          'Ride sharing',
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          SwitchIcon.toggle_off,
                          color: black,
                          size: 15,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
