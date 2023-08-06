import 'package:drivn_app/features/cars/presentations/widget/car.carousel.dart';
import 'package:flutter/material.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Car details')),
      body: ListView(children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height / 3.5,
          child: CarCarousel(),
        ),
      ]),
    );
  }
}
