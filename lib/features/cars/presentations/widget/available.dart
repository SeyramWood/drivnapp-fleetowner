import 'package:drivn_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CarsAvailableBuilder extends StatelessWidget {
  const CarsAvailableBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(
          height: 200,
        ),
        Align(
          alignment: Alignment.center,
          child: CarTile(),
        ),
      ],
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
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width / 3,
            child: Container(
              child: Image.asset('assets/logo.png'),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //this container has the cars name and it's ratings
                Container(
                  padding: EdgeInsets.all(5),
                  height: 45,
                  decoration: BoxDecoration(
                    color: black.withOpacity(0.1),
                    border: Border.all(color: black.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                      key: key,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Mercedes Benz'),
                        Spacer(),
                        Icon(
                          Icons.star_border_outlined,
                          color: yellow,
                        ),
                        Text('4.8')
                      ]),
                ),
                ///////
                Row(
                  children: [
                    Text('& 20'),
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'With driver',
                          style: TextStyle(fontSize: 10),
                        ),
                        Transform.scale(
                          scale: 0.2,
                          child: Switch(
                            onChanged: (value) {},
                            value: true,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'With driver',
                          style: TextStyle(fontSize: 10),
                        ),
                        Transform.scale(
                          scale: 0.2,
                          child: Switch(
                            onChanged: (value) {},
                            value: true,
                          ),
                        ),
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
