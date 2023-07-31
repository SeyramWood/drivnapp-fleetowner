import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.99,
      height: 140.0,
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  // First Column - Image (30%)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Image.asset(
                      'assets/car1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10.0), // Add some space between the columns
                  // Second Column - Text and Icons
                  Expanded(
                    child: Column(
                      children: [
                        // First Row
                        Row(
                          children: [
                            Text(
                              'Mercedes-Benz',
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.star),
                            Text('4.8'),
                          ],
                        ),
                        // Second Row
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "GHS 20",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'With driver',
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.toggle_on),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Ride sharing',
                              style: TextStyle(fontSize: 12),
                            ),
                            Icon(Icons.toggle_off),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  // First Column - Image (30%)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Image.asset(
                      'assets/car1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10.0), // Add some space between the columns
                  // Second Column - Text and Icons
                  Expanded(
                    child: Column(
                      children: [
                        // First Row
                        Row(
                          children: [
                            Text(
                              'Mercedes-Benz',
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.star),
                            Text('4.8'),
                          ],
                        ),
                        // Second Row
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "GHS 20",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'With driver',
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.toggle_on),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Ride sharing',
                              style: TextStyle(fontSize: 12),
                            ),
                            Icon(Icons.toggle_off),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
